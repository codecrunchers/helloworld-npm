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

    stage("Package"){
        dir('app'){
                sh 'npm prune'
                sh 'npm version'
                sh 'pac'
                REPLACE_TOKEN_FILE_VAL=sh(returnStdout: true, script: 'npm pack').trim()
                
                REPLACE_TOKEN_VERSION_VAL=sh(returnStdout: true,
                        script: "cat package.json | grep 'version.*' | cut -d':' -f2  | sed s'/\"//g' | sed s'/,//'").trim()
                
                sshagent(['git']) {
                    sh 'git config  user.email "pipeline@p9e.io" && git config user.name "Build Pipeline"' //need to use withEnv
                    sh 'git tag -a "v' +REPLACE_TOKEN_VERSION_VAL +'" -m "Release Candidate ' + REPLACE_TOKEN_FILE_VAL + '"'
                    sh 'git push --tags'
                }
                sh 'cp "${REPLACE_TOKEN_FILE_VAL}" "latest.tgz"'
                sh 'node scripts/deploy.js'
        }
    }

}



