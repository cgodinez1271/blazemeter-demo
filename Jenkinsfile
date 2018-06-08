node {
   stage('Build') {
      // Build
   }
   stage('Performance Tests') {
    // Get code from Github repository
    sh 'git clone git@github.com:cgodinez1271/taurus.git taurus'
    parallel(
        BlazeMeterTest: {
            dir ('taurus') {
                sh 'bzt test.yml -report'
            }
        },
        Analysis: {
            sleep 60
        })
   }
   stage(‘Deploy’) {
     // Deploy
   }
}
