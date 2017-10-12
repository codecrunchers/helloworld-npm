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

    stage("Deploy"){
	    	dir('tf'){
				sh 'terraform validate';
				sh 'terraform plan';
                sh 'terraform apply'; //if plan e.g. has "0 to Destroy"
			}
	}


}




