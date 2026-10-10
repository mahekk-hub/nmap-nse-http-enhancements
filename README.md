# Enhancing Nmap NSE Scripts: HTTP Response Profiling and HEAD–GET Comparison

**Author:** Mahek Lapsiwala

## 1. Introduction
Nmap (Network Mapper) is a network exploration and security testing tool. The Nmap Scripting Engine (NSE) allows users to automate network tasks
using Lua scripts.

This project extends HTTP information gathering through two custom NSE scripts developed using Nmap's HTTP library.

## 2. Reference Scripts
### Reference 1: http-security-header-check.nse
This original DA1 script sends an HTTP GET request to the root path and retrieves the Server response header.

### Reference 2: http-headers.nse
The official Nmap script performs a HEAD request and displays the HTTP headers returned by a web server.

Official source:
https://github.com/nmap/nmap/blob/master/scripts/http-headers.nse

## 3. Enhancement Option 1: HTTP Response Profiler
File: `http-response-profiler.nse`
This script retrieves an HTTP response and displays its status code and selected response headers in organised sections.
It reports fields such as Server, Content-Type, Date, Cache-Control, and selected HTTP security-related headers.
The output presents the values returned by the server without assigning security scores or ratings.

## 4. Enhancement Option 2: HTTP HEAD–GET Comparator
File: `http-head-get-comparator.nse`
This script sends HEAD and GET requests to the same resource and compares their HTTP response headers.
It identifies headers with the same values, headers with different values, and headers returned by only one request.

## 5. Technologies Used
- Nmap 7.94SVN
- Nmap Scripting Engine (NSE)
- HTTP protocol

## 6. Execution
Run the HTTP Response Profiler:
```bash
nmap -Pn -p 80 --script ./http-response-profiler.nse scanme.nmap.org
