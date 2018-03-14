class InvalidJobs < StandardError; end

class RubyTest

  def sequence(jobs)
    dependency_check(jobs)
    error_check(jobs)
    job_order(jobs)
  end

  #private

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

  def compact_hash(jobs)
    compact_hash = parse(jobs).compact
  end

  def circular_check(jobs_hash)
    errors = []
    compact_hash(jobs_hash).each do |_, v|
      keys = compact_hash(jobs_hash).keys
      if keys.include?(v)
        key_pair = compact_hash(jobs_hash).select { |k,value| k == v }.to_a.flatten
        errors << key_pair unless errors.include?(key_pair)
      end
    end
    return errors.flatten!
  end

  def error_count(errors)
    errors_to_check = circular_check(errors)
    count = 0
    if errors_to_check != nil
    errors_to_check.each_with_index do |error, index|
       next_error = errors_to_check[index+1]
       previous_error = errors_to_check[index-1]
         if error == previous_error
          count += 1
         end
       end
     end
       count
    end

    def error_check(count)
     if error_count(count) > 1
       raise InvalidJobs, "Job lists cannot contain circular references"
     end
    end

end
