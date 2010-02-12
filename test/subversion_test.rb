require File.expand_path('../start', __FILE__)

describe "Locke::Subversion::Repository" do
  before do
    repository = File.join(Test.root, 'fixtures', 'svn-project')
    checkout   = File.join(Test.root, 'fixtures', 'svn-project-checkout')
    
    @repository = Locke::Subversion::Repository.new(checkout)
    @repository.svn "checkout file://#{repository} #{checkout}"
  end
  
  after do
    FileUtils.rm_rf(File.join(Test.root, 'fixtures', 'svn-project-checkout'))
  end
  
  it "should return the last revision of a subversion repository" do
    @repository.last_revision.should == 5
  end
  
  it "should return a list changes to the repository" do
    @repository.changes.should == [
      {:revision => 1, :added=>0, :removed=>0},
      {:revision => 2, :added=>1, :removed=>0},
      {:revision => 3, :added=>1, :removed=>1},
      {:revision => 4, :added=>5, :removed=>1},
      {:revision => 5, :added=>1, :removed=>3}
    ]
  end
  
  it "should accept blocks to iterate through changes" do
    count = 0
    @repository.each_change do |change|
      count += 1
      change.should.be.kind_of(Hash)
    end
    count.should == @repository.last_revision
  end
end