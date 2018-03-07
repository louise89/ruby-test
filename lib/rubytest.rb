class RubyTest

  def job_order(job)
    grouped_jobs = job.group_by {|key, value| value}
    grouped_jobs.flatten.flatten.uniq.compact
  end


end
