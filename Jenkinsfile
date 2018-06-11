node {
  stage('Performance Tests') {
    // Get code from Github repository
    sh 'rm -rf taurus'
    sh 'git clone git@github.com:cgodinez1271/taurus.git taurus'
    BlazeMeterTest: {
      dir ('taurus') {
        sh 'bzt test.yml -report'
      }
    }
  }
}
