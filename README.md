README for Ordered Jobs.

Original Submission;
My original submission for this test had several errors.
The rspec testing did not work as I think that rspec was not correctly installed - and the testing suite written was generally poor.
The circular dependency check worked for the example but did not work for any others
The method I used to order the jobs is generally a bit woolly and works only by coincidence and crossing your fingers.

New Submission;
There are still some flaws in this one, however I think it is generally improved.
The rspec testing now works - except for one test, which I have left on purpose to show the limitations in my current method.
I have re-written the circular check and this now works for other circular dependencies.
I have purposefully left the grouped jobs method the same, however it faces the same issues as in the original.

I have chosen to leave this as it is, as when I was looking on the internet for help I accidentally stumbled across an answer.
Unfortunately, I was unaware that this test was a published kata. Once I saw the answer that had been submitted I then struggled to find another method that would also work and be as precise. I am unwilling to submit work for this exercise that is not my own so I chose to leave my original flawed method in place instead of plagiarising another persons work.

The method that was used was essentially;
def sequence(jobs_hash)
  keys = jobs_hash.keys
  jobs_hash.each do |job, dependency|
    if keys.include?(dependency)
      index = keys.index(job)
      keys.insert(index, dependency)
    end
  end
  keys.uniq
end

I have unfortunately run a bit short on time, however if i was to continue to refactor this code further I would continue to try finding a different method for sorting the jobs and I would also look at moving all the other methods into private and removing the extra tests. I also think that some of my methods are a bit difficult to read and are too verbose, so I would look at breaking some bits out to other methods.

Louise
