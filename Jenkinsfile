node('master') {

    currentBuild.result = "SUCCESS"

    try {

       stage('Checkout'){

          checkout scm
       }

       stage('Test'){

         env.NODE_ENV = "test"

         print "Environment will be : ${env.NODE_ENV}"
         
         sh 'yum install -y gcc-c++ make ; curl -sL https://rpm.nodesource.com/setup_6.x | sudo -E bash - ; yum install nodejs -y'
         sh 'node -v ;npm prune ;  npm test'
       }

       stage('Build Docker'){
            sh 'chmod +x dockerBuild.sh'
            sh 'id'
            sh './dockerBuild.sh'
            sh 'node server'
       }

       stage('Deploy'){
      
            echo 'We can verify the new node.js application run'
            sh './jenkins/deliver.sh'
        }

       stage('Cleanup'){

         echo 'prune and cleanup'
         sh 'npm prune'
         sh 'rm node_modules -rf'

         mail body: 'project build successful',
                     from: 'xxxx@yyyyy.com',
                     replyTo: 'xxxx@yyyy.com',
                     subject: 'project build successful',
                     to: 'js.mca2009@gmail.com'
       }
}
       catch (err) {

        currentBuild.result = "FAILURE"

            mail body: "project build error is here: ${env.BUILD_URL}" ,
            from: 'xxxx@yyyy.com',
            replyTo: 'yyyy@yyyy.com',
            subject: 'project build failed',
            to: 'zzzz@yyyyy.com'

        throw err
    }

}

