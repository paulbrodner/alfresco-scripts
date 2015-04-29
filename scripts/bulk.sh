#!/bin/bash

rake scripts:run CMD=3,1,4 INTERACTIVE=true &&
rake scripts:run CMD=3,2,4 &&	
rake scripts:run CMD=3,3,4 &&
rake scripts:run CMD=3,4,4 &&
