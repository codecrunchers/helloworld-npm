node('nodejs_slave'){
        stage("Checkout"){
            checkout scm;
        }
    
    stage("Install"){
	    	dir('app'){
				sh 'npm install';
			}
	}
}




