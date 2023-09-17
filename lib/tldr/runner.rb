class TLDR
  class Runner
    TestResult = Struct.new :test, :error

    def run plan
      $stdout.sync = true
      $stderr.sync = true

      Thread.new {
        sleep 1.8
        $stderr.print "🥵"
        puts "\n\ntoo long; didn't run"
        exit!
      }

      plan.tests.map { |test|
        begin
          instance = test.klass.new
          instance.send(test.method)
          $stdout.print "😁"
        rescue SkipTest => e
          $stdout.print "🫥"
        rescue Assertions::Failure => e
          $stderr.print "😡"
        rescue => e
          $stderr.print "🤬"
        end
        TestResult.new test, e
      }
    end
  end
end
