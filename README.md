# Enhancing Nmap NSE Scripts: HTTP Response Profiling and HEAD–GET Comparison
**Author:** Mahek Lapsiwala

## 1. Introduction
Nmap (Network Mapper) is a network exploration and security testing tool used to discover hosts, open ports, and services on a network. The Nmap Scripting Engine (NSE) enables users to automate network tasks using Lua scripts.
This project enhances HTTP information gathering by developing two custom NSE scripts based on the original DA1 script and the official Nmap `http-headers.nse` script.
The project focuses on organising HTTP response information and comparing the headers returned by different HTTP request methods.

## 2. Reference Scripts
### Reference 1: http-security-header-check.nse
This original DA1 script sends an HTTP GET request to the root path (`/`) of a web server and retrieves the `Server` HTTP response header.
It displays the server information when the header is available and reports when the header is not found.

### Reference 2: http-headers.nse
The official Nmap `http-headers.nse` script performs a HEAD request to retrieve HTTP response headers. If the HEAD request fails, it can fall back to a GET request.
It displays the headers returned by the web server and identifies the request method used.

**Official source:**  
https://github.com/nmap/nmap/blob/master/scripts/http-headers.nse

## 3. Enhancement Option 1: HTTP Response Profiler
**Script:** `http-response-profiler.nse`

### Description
The HTTP Response Profiler extends the original header-retrieval functionality by organising HTTP response information into clearly labelled sections.
The script sends a GET request to the root path and displays the HTTP status and selected response headers.
The selected headers include:
- Server
- Content-Type
- Content-Length
- Date
- Last-Modified
- Cache-Control
- Location
- X-Frame-Options
- X-Content-Type-Options
- Content-Security-Policy

When a selected header is not returned, the script displays `Not Returned`.
This enhancement makes the response information easier to read and compare. It reports the values received from the server without assigning security scores, ratings, or good/bad classifications.

### Execution
```bash
nmap -Pn -p 80 --script ./http-response-profiler.nse scanme.nmap.org
```

Run this command from the directory containing the script. The target must be reachable, and TCP port 80 must be accessible.

## 4. Enhancement Option 2: HTTP HEAD–GET Comparator
**Script:** `http-head-get-comparator.nse`
### Description
The HTTP HEAD–GET Comparator compares the HTTP response headers obtained from HEAD and GET requests to the same resource.
The script displays the status codes returned by both requests and compares the response headers.
It identifies three situations:
1. **Same value:** A header is returned by both requests with the same value.
2. **Different values:** A header is returned by both requests, but its values differ.
3. **Present only in one request:** A header is returned by only HEAD or only GET.

This enhancement helps users observe differences between HTTP response metadata returned by the two request methods.
For example, a `Date` header may differ because the requests occur at different times. A header may also appear in one response but not the other.
The script reports these differences without assigning security scores or ratings.

### Execution
```bash
nmap -Pn -p 80 --script ./http-head-get-comparator.nse scanme.nmap.org
```

Run this command from the directory containing the script. The target must be reachable, and TCP port 80 must be accessible.

## 5. Technologies Used
- Nmap 7.94SVN
- Nmap Scripting Engine (NSE)
- Lua
- HTTP protocol

## 6. Testing and Results
Both custom NSE scripts were tested against `scanme.nmap.org` on TCP port 80.

### 6.1 HTTP Response Profiler
The script successfully retrieved the HTTP response and reported status code `200`.
The observed output included:
- Server: `Apache/2.4.7 (Ubuntu)`
- Content-Type: `text/html`
- Date: `Sat, 10 Oct 2026 19:15:44 GMT`

The script also displayed `Not Returned` for selected headers that were absent from the received response.
These results demonstrate that the script can retrieve HTTP response information and organise selected headers into a readable report.

### 6.2 HTTP HEAD–GET Comparator
The script successfully retrieved responses for both request methods.
The observed output showed:
- HEAD Status: `200`
- GET Status: `200`
- Several headers with the same values
- A difference in the `Date` header
- `transfer-encoding` present only in the GET response
The difference in the `Date` header was consistent with the requests occurring at different times.
These results demonstrate that the script can compare response metadata and report differences between HEAD and GET responses.

**Note:** The results above represent the responses observed during testing. Server configurations, response headers, and values may change between requests.

## 7. Learning Outcomes
Through this project, the following concepts were explored:
- Understanding the structure and purpose of Nmap NSE scripts.
- Using Nmap's HTTP library to retrieve HTTP responses.
- Accessing HTTP status codes and response headers.
- Organising response metadata into readable output.
- Comparing HTTP headers returned by HEAD and GET requests.
- Identifying matching headers, differing values, and headers present in only one response.
- Testing custom NSE scripts against a reachable HTTP service.
- Understanding that HTTP response differences can occur for reasons such as request timing and server configuration.

## 8. Conclusion
This project demonstrates two enhancements to HTTP information gathering using the Nmap Scripting Engine.
The HTTP Response Profiler organises HTTP status information and selected response headers into a structured report. The HTTP HEAD–GET Comparator compares response metadata returned by two HTTP request methods and identifies similarities and differences.

Together, the scripts demonstrate how existing Nmap NSE functionality can be extended to provide more organised and comparative HTTP response information.

## 9. Acknowledgements
I acknowledge the Nmap project and its contributors for providing Nmap, the Nmap Scripting Engine and its HTTP library.
I also thank the School of Computer Science and Engineering (SCOPE), VIT Chennai, and the faculty for the opportunity to explore network scanning, scripting and HTTP response analysis as part of the academic assignment.
