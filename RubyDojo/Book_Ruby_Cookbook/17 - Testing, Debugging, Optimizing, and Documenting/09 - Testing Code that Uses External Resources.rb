class VersionControlMaintenance

  DAY_SECONDS = 60 * 60 * 24

  def initialize(vcs)
    @vcs = vcs
  end   

  def purge_old_labels(age_in_days)
    @vcs.connect
    old_labels = @vcs.label_list.select do |label| 
      label['date'] <= Time.now - age_in_days * DAY_SECONDS
    end
    @vcs.label_delete(*old_labels.collect{|label| label['name']})
    @vcs.disconnect
  end

end
#---
require 'rubygems'
require 'flexmock'
require 'test/unit'

class VersionControlMaintenanceTest < Test::Unit::TestCase

  DAY_SECONDS = 60 * 60 * 24
  LONG_AGO = Time.now - DAY_SECONDS * 3 
  RECENT   = Time.now - DAY_SECONDS * 1 
  LABEL_LIST = [ 
                 { 'name' => 'L1', 'date' => LONG_AGO },
                 { 'name' => 'L2', 'date' => RECENT   }
               ]
#---
  def test_purge
    FlexMock.use("vcs") do |vcs|
      vcs.should_receive(:connect).with_no_args.once.ordered

      vcs.should_receive(:label_list).with_no_args.
          and_return(LABEL_LIST).once.ordered

      vcs.should_receive(:label_delete).
          with('L1').once.ordered

      vcs.should_receive(:disconnect).with_no_args.once.ordered
#---
      v = VersionControlMaintenance.new(vcs)
      v.purge_old_labels(2)
        
      # The mock calls will be automatically varified as we exit the
      # @FlexMock.use@ block.
    end
  end
end
#---
# Simulate an exception in the mocked object.
mock.should_receive(:connect).and_return{ raise ConnectionFailed.new }

# Simulate a spotty connection: the first attempt fails
# but when the exception handler retries, we connect.
i = 0
mock.should_receive(:connect).twice.
  and_return{ i += 1; raise ConnectionFailed.new unless i > 1 }
end
#---
class ChangeHistoryReport
  def date_range(label1, label2)
    vc = VersionControl.new
    vc.connect
  dates = [label1, label2].collect do |label|
      vc.fetch_label(label).files.sort_by{|f|f['date']}.last['date']
    end
    vc.disconnect
    return dates
  end
end
#---
require 'class_intercepter'
require 'test/unit'

class ChangeHistoryReportTest < Test::Unit::TestCase

  def test_date_range
  FlexMock.use('vc') do |vc| 
      
      # initialize the mock
      vc.should_receive(:connect).once.ordered
      vc.should_receive(:fetch_label).with(LABEL1).once.ordered
      vc.should_receive(:fetch_label).with(LABEL2).once.ordered
      vc.should_receive(:disconnect).once.ordered
      vc.should_receive(:new).and_return(vc)
#---
      ChangeHistoryReport.use_class(:VersionControl, vc) do
#---
        c = ChangeHistoryReport.new
        c.date_range(LABEL1, LABEL2)
      end
    end
  end
end
#---
