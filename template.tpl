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
  "description": "AI agent detection pixel for protecting websites from automated bot traffic. Detects and blocks AI agents while allowing genuine human users.",
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
    "help": "Your AgentShield project ID. You can find this in your AgentShield dashboard.",
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
    "help": "Custom API endpoint URL. Leave blank to use the default endpoint.",
    "defaultValue": ""
  },
  {
    "type": "CHECKBOX",
    "name": "debugMode",
    "checkboxText": "Enable Debug Mode",
    "simpleValueType": true,
    "help": "Enable debug logging in browser console. Recommended for testing only.",
    "defaultValue": false
  },
  {
    "type": "TEXT",
    "name": "sessionTimeout",
    "displayName": "Session Timeout (ms)",
    "simpleValueType": true,
    "help": "Session timeout in milliseconds. Default is 1800000 (30 minutes).",
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
    "help": "Respect user's Do Not Track browser setting.",
    "defaultValue": true
  },
  {
    "type": "TEXT",
    "name": "batchSize",
    "displayName": "Batch Size",
    "simpleValueType": true,
    "help": "Number of events to batch before sending. Default is 10.",
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
    "help": "How often to flush batched events in milliseconds. Default is 5000 (5 seconds).",
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
    "help": "Enable advanced browser fingerprinting for better detection accuracy.",
    "defaultValue": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const log = require('logToConsole');
const injectScript = require('injectScript');
const createQueue = require('createQueue');
const getUrl = require('getUrl');

// Get template parameters
const projectId = data.projectId;
const apiEndpoint = data.apiEndpoint || '';
const debugMode = data.debugMode || false;
const sessionTimeout = data.sessionTimeout || 1800000;
const respectDoNotTrack = data.respectDoNotTrack !== false;
const batchSize = data.batchSize || 10;
const flushInterval = data.flushInterval || 5000;
const enableFingerprinting = data.enableFingerprinting !== false;

// Default CDN URL - this will be determined from the script source
const defaultCdnUrl = 'https://kya.vouched.id';

if (debugMode) {
  log('AgentShield GTM Template - Starting initialization');
  log('Project ID:', projectId);
}

// Create the pixel script element
const pixelScript = '(function() {' +
  'var as = document.createElement("script");' +
  'as.type = "text/javascript";' +
  'as.async = true;' +
  'as.src = "' + defaultCdnUrl + '/pixel.js";' +
  'as.setAttribute("data-project-id", "' + projectId + '");' +
  (apiEndpoint ? 'as.setAttribute("data-api-endpoint", "' + apiEndpoint + '");' : '') +
  (debugMode ? 'as.setAttribute("data-debug", "true");' : '') +
  'as.setAttribute("data-session-timeout", "' + sessionTimeout + '");' +
  (respectDoNotTrack ? 'as.setAttribute("data-respect-dnt", "true");' : 'as.setAttribute("data-respect-dnt", "false");') +
  'as.setAttribute("data-batch-size", "' + batchSize + '");' +
  'as.setAttribute("data-flush-interval", "' + flushInterval + '");' +
  (enableFingerprinting ? 'as.setAttribute("data-enable-fingerprinting", "true");' : 'as.setAttribute("data-enable-fingerprinting", "false");') +
  'var s = document.getElementsByTagName("script")[0];' +
  's.parentNode.insertBefore(as, s);' +
  '})();';

// Inject the script directly into the page
const scriptElement = document.createElement('script');
scriptElement.innerHTML = pixelScript;
document.head.appendChild(scriptElement);

if (debugMode) {
  log('AgentShield GTM Template - Pixel script injected successfully');
}

// Call data.gtmOnSuccess when the tag is finished.
data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "type": "inject_script",
    "urls": [
      "https://kya.vouched.id/*",
      "https://agentshield.io/*"
    ]
  },
  {
    "type": "access_globals",
    "keys": [
      {
        "key": "AgentShield",
        "read": true,
        "write": true,
        "execute": false
      }
    ]
  }
]


___TESTS___

[]


___NOTES___

Created on 8/21/2025, 12:00:00 PM