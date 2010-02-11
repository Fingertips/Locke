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
  
  it "should get the last revision of a subversion repository" do
    @repository.last_revision.should == 5
  end
end