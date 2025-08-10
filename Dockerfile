services:
  - type: web
    name: laravel
    env: docker
    plan: free
    autoDeploy: true
    region: oregon
    dockerfilePath: Dockerfile
    branch: main
    healthCheckPath: /
    envVars:
      - key: APP_ENV
        value: production
      - key: APP_KEY
        sync: false
