class RubyTest

  def parse(jobs)
    jobs_hash = Hash[jobs.split(", ").map{|x| x.split(/\s\=\>\s?/)}]
end

  def job_order(jobs_hash)
    grouped_jobs = parse(jobs_hash).group_by {|key, value| value}
    grouped_jobs.flatten.flatten.uniq.compact
  end


end
