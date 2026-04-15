pipeline {
    agent { label 'azure-linux-ubuntu-18' }
    options {
        skipStagesAfterUnstable()
        disableConcurrentBuilds()
    }
    stages {
        stage("Clone Git Repo") {
            steps {
                cleanWs()
                script {
                    def branchName = env.CHANGE_BRANCH ?: env.BRANCH_NAME
                    env.branchName = branchName
                    echo "Using branch/commit: ${env.BRANCH_NAME}"
                }
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: "refs/heads/${env.branchName}"]],
                    doGenerateSubmoduleConfigurations: false,
                    extensions: [
                        [$class: 'RelativeTargetDirectory', relativeTargetDir: 'podio-objc'],
                        [$class: 'CloneOption', shallow: true, depth: 1, noTags: false]
                    ],
                    submoduleCfg: [],
                    userRemoteConfigs: [[credentialsId: 'github-app-podio-jm', url: 'https://github.com/podio/podio-objc.git']]
                ])
            }
        }
    }
}
