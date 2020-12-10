___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "categories": ["UTILITY"],
  "__wm": "VGVtcGxhdGUtQXV0aG9yX1RyYW5zYWN0aW9uSWRSZWFkZXItU2ltby1BaGF2YQ==",
  "displayName": "Transaction ID Reader",
  "description": "Designed to work with the \"Transaction ID Logger\" tag template. This variable returns either true/false upon checking if the current Transaction ID has already been logged, or the full array of IDs.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "transactionId",
    "displayName": "Transaction ID",
    "macrosInSelect": true,
    "selectItems": [],
    "simpleValueType": true
  },
  {
    "type": "RADIO",
    "name": "returnType",
    "displayName": "Variable Return Type",
    "radioItems": [
      {
        "value": "boolean",
        "displayValue": "Boolean (true/false)"
      },
      {
        "value": "array",
        "displayValue": "Array"
      }
    ],
    "simpleValueType": true,
    "help": "If you choose \u003cstrong\u003eBoolean\u003c/strong\u003e, the variable returns \u003cstrong\u003etrue\u003c/strong\u003e if the ID is found in the array of logged IDs, or \u003cstrong\u003efalse\u003c/strong\u003e if not. If you choose \u003cstrong\u003eArray\u003c/strong\u003e, the variable returns the array of all logged IDs."
  },
  {
    "type": "LABEL",
    "name": "label1",
    "displayName": "This variable has been designed to work with the \u003ca href\u003d\"https://www.simoahava.com/custom-templates/transaction-id-logger/\"\u003eTransaction ID Logger\u003c/a\u003e tag template."
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Load APIs
const getCookieValues = require('getCookieValues');
const json = require('JSON');
const localStorage = require('localStorage');

const key = '__tid_gtm';

let cookieIDs = getCookieValues(key);
let localStorageIDs = localStorage.getItem(key);
const transactionId = data.transactionId;
cookieIDs = cookieIDs.length ? json.parse(cookieIDs[0]) : [];
localStorageIDs = localStorageIDs ? json.parse(localStorageIDs) : [];

// If no transaction ID is found, do nothing.
if (!transactionId) return undefined;

if (data.returnType === 'boolean') {
  // Return true if either cookieIDs or localStorageIDs has the transaction ID
  return cookieIDs.indexOf(transactionId) > -1 || localStorageIDs.indexOf(transactionId) > -1;
} else {
  // Return the full, concatenated and deduplicated array of all cookie IDs and localStorage IDs
  return cookieIDs.concat(localStorageIDs.filter(item => cookieIDs.indexOf(item) === -1));
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "__tid_gtm"
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
        "publicId": "access_local_storage",
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
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "__tid_gtm"
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
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 10/12/2020, 12:48:23


