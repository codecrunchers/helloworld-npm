var deployer = require('nexus-deployer');

var release = {
    groupId: 'p9',
    artifactId: 'hello-env',
    version: 'REPLACE_TOKEN_VERSION',
    packaging: 'tgz',
    auth: {
      username:'admin',
      password:'admin123'
    },
    pomDir: '.',
    url: 'http://dev-AWSPipeline-alb-1262846891.eu-west-1.elb.amazonaws.com/nexus/content/repositories/releases',
    artifact: 'REPLACE_TOKEN_FILE',
    noproxy: 'localhost',
    cwd: ''
};


deployer.deploy(release, function(){
    // your async call back here
    // done();
    console.log("Released")
});



