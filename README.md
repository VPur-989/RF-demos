# RF-demos

Copied from my personal contribution to a project at JAMK.

## Tested gitlab-ci.yaml base for running Robot Framework tests 

Use something like this as a base to run robot scripts as part of a pipeline. It creates a container that can run SeleniumLibrary scripts using headless Firefox. Currently the artifacts are not saved if any of the test cases fail, looking for a workaround.

```
stages:
    - test

test:
    stage: test
    image: python:3-alpine
    script:
    - mkdir reports
    - apk add firefox
    - pip install robotframework robotframework-seleniumlibrary
    - robot --outputdir reports  robot-tests/robot-script-to-be-tested.robot 
    artifacts:
            paths:
                - reports
```

Running scripts with the Browser library requires different dependencies. This kind of setup worked.
```
test:
    stage: test
    image: marketsquare/robotframework-browser
    script:
    - mkdir reports
    - pip install robotframework robotframework-browser
    - rfbrowser init
    - robot --outputdir reports   robot-tests/test_with_browserlib.robot 
    artifacts:
            paths:
                - reports
```
