RELEASE_CANDIDATE_VERSION="0.0.0"

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
            withSonarQubeEnv {
                sh "./${sonar_runner} clean sonarqube"
            }
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
            sh 'npm version'
                sh 'npm pac'
                sh 'cat package.json | grep version | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g' | tr -d '[[:space:]]') && git tag $PACKAGE_VERSION && git push --tags'
                RELEASE_CANDIDATE_VERSION = sh(returnStdout: true, script: 'npm pack').trim()
        }

        stage("Deploy"){
            dir('tf'){
                sh 'terraform validate';
                sh 'terraform plan';
                sh 'terraform apply'; //if plan e.g. has "0 to Destroy"
            }
        }


    }

    def get_git_sha(git_dir='') {
        dir('app') {
            return sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
        }
    }


