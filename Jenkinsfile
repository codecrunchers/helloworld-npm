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
			}
	}

    stage("Sonar"){
	    	dir('app'){
				sh 'echo \"Do Sonar!\"';
			}
	}


    stage("Deploy"){
	    	dir('tf'){
				sh 'terraforfm validate';
				sh 'terraform plan';
			}
	}


}




