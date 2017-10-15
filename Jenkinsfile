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

/*    stage("Sonar Analysis"){
        dir('app'){
            withSonarQubeEnv {
                sh "./${sonar_runner} clean sonarqube"
            }
        }
    }


    stage("Analysis") {
        parallel "performance": {
            node('nodejs_slave') {
                checkout scm
                    sh 'npm run test:integration'
            },
            "security": node('nodejs_slave') {
              checkout scm
                  sh 'npm run test:performance'
          }
        }
    }
*/

    stage("Package"){
        dir('app'){
            sh 'npm version'
                sh 'pac'
                REPLACE_TOKEN_FILE_VAL=sh(returnStdout: true, script: 'npm pack').trim()
                sh "sed -i 's/REPLACE_TOKEN_FILE/REPLACE_TOKEN_FILE_VAL/g' scripts/deploy.js"
                REPLACE_TOKEN_VERSION_VAL=sh(returnStdout: true,
                        script: "cat package.json | grep 'version.*' | cut -d':' -f2  | sed s'/\"//g' | sed s'/,//'").trim()
                sh "sed -i 's/REPLACE_TOKEN_VERSION/REPLACE_TOKEN_VERSION_VAL/g' scripts/deploy.js"
                sh 'git tag -a "v${REPLACE_TOKEN_VERSION_VAL}" -m "Release Candidate"'
                sh 'git config  user.email "pipeline@p9e.io" && git config user.name "Build Pipeline"'
                sh 'git push --tags'
                sh 'node scripts/deploy.js'
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

    def get_git_sha(git_dir='') {
        dir('app') {
            return sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
        }
    }


