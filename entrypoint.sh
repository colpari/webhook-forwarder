#!/bin/bash

VERBOSE_FLAG=""
if [ "$VERBOSE" = true ] ; then
  VERBOSE_FLAG="--verbose"
fi

exec webhook-forwarder serve --port "${PORT:-":8080"}" ${VERBOSE_FLAG}
