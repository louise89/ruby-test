class InvalidJobs < StandardError; end

class RubyTest

  def sequence(grouped_jobs)
    dependency_check(jobs)
    error_check(jobs)
    job_order(jobs_hash)
  end

  def parse(jobs)
    jobs_hash = Hash[jobs.split(", ").map{|x| x.split(/\s\=\>\s?/)}]
  end

  def job_order(jobs_hash)
    grouped_jobs = parse(jobs_hash).group_by {|key, value| value}
    grouped_jobs.flatten.flatten.uniq.compact
  end

  def dependency_check(jobs)
    dedupe_jobs = parse(jobs).each do |key, value|
      if key == value
        raise InvalidJobs, "A job cannot refer to itself!"
      end
    end
  end

  #def compact_hash(jobs_hash)
  #end

  def circular_check(jobs)
    errors = []
    compact_hash = parse(jobs).compact
    compact_hash.each do |_, v|
      keys = compact_hash.keys
      if keys.include?(v)
        key_pair = compact_hash.select { |k,value| k == v }.to_a.flatten
        errors << key_pair unless errors.include?(key_pair)
      end
    end
    errors.flatten
  end

  def error_count(errors)
    errors_to_check = circular_check(errors)
    count = 0
    errors_to_check.each_with_index do |error, index|
       next_error = errors[index+1]
       previous_error = errors[index-1]
         if error == previous_error
          count += 1
         end
       end
       count
     end

    def error_check(count)
     if count > 0
       raise InvalidJobs, "Job lists cannot contain circular references"
     end
    end
    
end
