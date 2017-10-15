node('nodejs_slave'){
    stage("Checkout"){
        checkout scm;
    }

    stage("Install"){
        dir('app'){
            sh 'npm install';
        }
    }

    stage("Unit Test"){
        dir('app'){
            sh 'npm run test:unit';
            sh 'npm run test:lint';
        }
    }

    stage("Sonar Analysis"){
        dir('app'){
            sh 'echo "do sonar runner"';
        }
    }


    stage("Analysis") {
        parallel performance: {
            node('nodejs_slave') {
                checkout scm
                    sh 'npm run test:integration'
            },
            security: node('nodejs_slave') {
              checkout scm
             sh 'npm run test:performance'
          }
        }
    }

    stage("Package"){
        dir('app'){
            sh 'npm pac'
            sh 'npm version'
            X = sh 'npm pack'


}        
    }



    stage("Deploy"){
        dir('tf'){
            sh 'terraform validate';
            sh 'terraform plan';
            sh 'terraform apply'; //if plan e.g. has "0 to Destroy"
        }
    }


                                                        }




