#!/usr/bin/env bash

rake scripts:run CMD=5,2,5 INTERACTIVE=true && rake scripts:run CMD=5,3,5 && rake scripts:run CMD=5,4,5 && rake scripts:run CMD=5,5,5
