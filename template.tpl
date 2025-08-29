___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "AgentShield Pixel",
  "brand": {
    "id": "brand_dummy",
    "displayName": "AgentShield",
    "thumbnail": ""
  },
  "description": "AI agent detection pixel for protecting websites from automated bot traffic",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "projectId",
    "displayName": "Project ID",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "apiEndpoint",
    "displayName": "API Endpoint (Optional)",
    "simpleValueType": true,
    "defaultValue": ""
  },
  {
    "type": "CHECKBOX",
    "name": "debugMode",
    "checkboxText": "Enable Debug Mode",
    "simpleValueType": true,
    "defaultValue": false
  },
  {
    "type": "TEXT",
    "name": "sessionTimeout",
    "displayName": "Session Timeout (ms)",
    "simpleValueType": true,
    "defaultValue": "1800000",
    "valueValidators": [
      {
        "type": "POSITIVE_NUMBER"
      }
    ]
  },
  {
    "type": "CHECKBOX",
    "name": "respectDoNotTrack",
    "checkboxText": "Respect Do Not Track",
    "simpleValueType": true,
    "defaultValue": true
  },
  {
    "type": "TEXT",
    "name": "batchSize",
    "displayName": "Batch Size",
    "simpleValueType": true,
    "defaultValue": "10",
    "valueValidators": [
      {
        "type": "POSITIVE_NUMBER"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "flushInterval",
    "displayName": "Flush Interval (ms)",
    "simpleValueType": true,
    "defaultValue": "5000",
    "valueValidators": [
      {
        "type": "POSITIVE_NUMBER"
      }
    ]
  },
  {
    "type": "CHECKBOX",
    "name": "enableFingerprinting",
    "checkboxText": "Enable Fingerprinting",
    "simpleValueType": true,
    "defaultValue": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const log = require('logToConsole');
const injectScript = require('injectScript');
const setInWindow = require('setInWindow');
const encodeUriComponent = require('encodeUriComponent');
const makeInteger = require('makeInteger');

const projectId = data.projectId;
const apiEndpoint = data.apiEndpoint || '';
const debugMode = data.debugMode === true;
const sessionTimeout = makeInteger(data.sessionTimeout) || 1800000;
const respectDoNotTrack = data.respectDoNotTrack !== false;
const batchSize = makeInteger(data.batchSize) || 10;
const flushInterval = makeInteger(data.flushInterval) || 5000;
const enableFingerprinting = data.enableFingerprinting !== false;

if (debugMode) {
  log('AgentShield GTM Template - Starting initialization');
  log('Configuration:', {
    projectId: projectId,
    apiEndpoint: apiEndpoint || 'default',
    sessionTimeout: sessionTimeout,
    respectDoNotTrack: respectDoNotTrack,
    batchSize: batchSize,
    flushInterval: flushInterval,
    enableFingerprinting: enableFingerprinting
  });
}

if (!projectId) {
  log('AgentShield Error: Project ID is required');
  return data.gtmOnFailure();
}

setInWindow('_agentShieldConfig', {
  projectId: projectId,
  apiEndpoint: apiEndpoint,
  debug: debugMode,
  sessionTimeout: sessionTimeout,
  respectDoNotTrack: respectDoNotTrack,
  batchSize: batchSize,
  flushInterval: flushInterval,
  enableFingerprinting: enableFingerprinting
}, true);

const baseUrl = 'https://kya.vouched.id/pixel.js';
let scriptUrl = baseUrl + '?project_id=' + encodeUriComponent(projectId);

if (apiEndpoint) {
  scriptUrl += '&api_endpoint=' + encodeUriComponent(apiEndpoint);
}
if (debugMode) {
  scriptUrl += '&debug=true';
}
scriptUrl += '&session_timeout=' + sessionTimeout;
scriptUrl += '&respect_dnt=' + respectDoNotTrack;
scriptUrl += '&batch_size=' + batchSize;
scriptUrl += '&flush_interval=' + flushInterval;
scriptUrl += '&enable_fingerprinting=' + enableFingerprinting;

const onSuccess = function() {
  if (debugMode) {
    log('AgentShield GTM Template - Pixel script loaded successfully');
    log('Script URL:', scriptUrl);
  }
  data.gtmOnSuccess();
};

const onFailure = function() {
  if (debugMode) {
    log('AgentShield GTM Template - Failed to load pixel script');
    log('Failed URL:', scriptUrl);
  }
  data.gtmOnFailure();
};

if (debugMode) {
  log('AgentShield GTM Template - Injecting script from:', scriptUrl);
}

injectScript(scriptUrl, onSuccess, onFailure);


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://kya.vouched.id/*"
              }
            ]
          }
        }
      ]
    }
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    }
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "_agentShieldConfig"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    }
  }
]


___TESTS___

scenarios: []
