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
  "categories": ["ANALYTICS", "TAG_MANAGEMENT"],
  "brand": {
    "id": "brand_dummy",
    "displayName": "AgentShield"
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
    ],
    "help": "Your AgentShield project ID. You can find this in your AgentShield dashboard."
  },
  {
    "type": "TEXT",
    "name": "apiEndpoint",
    "displayName": "API Endpoint (Optional)",
    "simpleValueType": true,
    "help": "Custom API endpoint URL. Leave blank to use the default endpoint."
  },
  {
    "type": "CHECKBOX",
    "name": "debugMode",
    "checkboxText": "Enable Debug Mode",
    "simpleValueType": true,
    "help": "Enable debug logging in browser console. Recommended for testing only."
  },
  {
    "type": "TEXT",
    "name": "sessionTimeout",
    "displayName": "Session Timeout (ms)",
    "simpleValueType": true,
    "help": "Session timeout in milliseconds. Default is 1800000 (30 minutes).",
    "defaultValue": 1800000,
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
    "help": "Respect user's Do Not Track browser setting.",
    "defaultValue": "checked",
    "displayName": "Respect Do Not Track"
  },
  {
    "type": "TEXT",
    "name": "batchSize",
    "displayName": "Batch Size",
    "simpleValueType": true,
    "defaultValue": 10,
    "valueValidators": [
      {
        "type": "POSITIVE_NUMBER"
      }
    ],
    "help": "Number of events to batch before sending. Default is 10."
  },
  {
    "type": "TEXT",
    "name": "flushInterval",
    "displayName": "Flush Interval (ms)",
    "simpleValueType": true,
    "help": "How often to flush batched events in milliseconds. Default is 5000 (5 seconds).",
    "defaultValue": 5000,
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
    "help": "Enable advanced browser fingerprinting for better detection accuracy.",
    "displayName": "Enable Fingerprinting",
    "defaultValue": "checked"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const log = require('logToConsole');
const injectScript = require('injectScript');
const setInWindow = require('setInWindow');
const encodeUriComponent = require('encodeUriComponent');
const makeInteger = require('makeInteger');

// Get template parameters with proper type conversion
const projectId = data.projectId;
const apiEndpoint = data.apiEndpoint || '';
const debugMode = data.debugMode === true;
const sessionTimeout = makeInteger(data.sessionTimeout) || 1800000;
const respectDoNotTrack = data.respectDoNotTrack !== false;
const batchSize = makeInteger(data.batchSize) || 10;
const flushInterval = makeInteger(data.flushInterval) || 5000;
const enableFingerprinting = data.enableFingerprinting !== false;

// Log initialization if debug mode is enabled
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

// Validate required fields
if (!projectId) {
  log('AgentShield Error: Project ID is required');
  return data.gtmOnFailure();
}

// Set configuration in window object for the script to read
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

// Build the script URL with query parameters
const baseUrl = 'https://kya.vouched.id/pixel.js';
let scriptUrl = baseUrl + '?project_id=' + encodeUriComponent(projectId);

// Add optional parameters to URL
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

// Success callback
const onSuccess = function() {
  if (debugMode) {
    log('AgentShield GTM Template - Pixel script loaded successfully');
    log('Script URL:', scriptUrl);
  }
  data.gtmOnSuccess();
};

// Failure callback
const onFailure = function() {
  if (debugMode) {
    log('AgentShield GTM Template - Failed to load pixel script');
    log('Failed URL:', scriptUrl);
  }
  data.gtmOnFailure();
};

// Inject the AgentShield pixel script
if (debugMode) {
  log('AgentShield GTM Template - Injecting script from:', scriptUrl);
}

injectScript(scriptUrl, onSuccess, onFailure);


___WEB_PERMISSIONS___

[
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
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
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
    },
    "isRequired": true
  },
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
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 8/29/2025, 10:56:04 PM
