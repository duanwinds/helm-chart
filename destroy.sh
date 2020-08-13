#!/bin/bash

helm delete first-server --purge
helm delete second-server --purge
helm delete third-server --purge
helm delete forth-server --purge
helm delete frontend-server --purge

