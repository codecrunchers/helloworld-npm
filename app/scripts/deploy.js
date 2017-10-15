var deployer = require('nexus-deployer');

var release = {
    groupId: 'nexus-deployer',
    artifactId: 'nexus-deployer',
    version: '1.0',
    packaging: 'zip',
    auth: {
      username:'admin',
      password:'admin123'
    },
    pomDir: '.',
    url: 'http://dev-AWSPipeline-alb-1262846891.eu-west-1.elb.amazonaws.com/nexus/content/repositories/releases',
    artifact: 'HelloWorld-3.4.0.tgz',
    noproxy: 'localhost',
    cwd: ''
};


deployer.deploy(release, function(){
    // your async call back here
    // done();
    console.log("Released")
});



