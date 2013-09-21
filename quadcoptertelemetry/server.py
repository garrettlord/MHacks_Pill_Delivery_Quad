import sys, string, cgi, time, json
from BaseHTTPServer   import BaseHTTPRequestHandler, HTTPServer
from SimpleHTTPServer import SimpleHTTPRequestHandler
import mavproxy
from mavproxy import *
from subprocess import Popen, PIPE, STDOUT
from pprint import pprint

def getTime():
    return time.strftime("%Y-%m-%d %H:%M:%S")

f = open("log.log", "a")
f.write("START SERVER: " + getTime() + "\n");

#server settings
DEFAULT_PORT = 8080
 
info_params = ["GLOBAL_POSITION_INT", "ATTITUDE", "SYS_STATUS", "VFR_HUD"]

info_vars = ["lat", "lon", "relative_alt", "roll", "pitch", "yaw", "flightBattery", "avionicsBattery", "voltage_battery", "current_battery", "airspeed", "groundspeed", "heading"]

class QuadCopterCommRequestHandler(SimpleHTTPRequestHandler):
    def __init__(self, request, client_address, server):
        print 'initializing request handler'
        SimpleHTTPRequestHandler.__init__(self, request, client_address, server)
        
    def do_GET(self):
        print "-> incoming GET"
        self.send_response(200)
        print "got stuff"
        # self.server.mpstate.rl.line = "get_info"
        mavproxy.cmd_status_new(info_params)
        temp_string = self.server.mpstate.dump_output_buffer()
        self.server.mpstate.clear_output_buffer()
        mavproxy.cmd_bat_new("")
        temp_string += "BATTERY {" + self.server.mpstate.dump_output_buffer() + "}"
        self.server.mpstate.clear_output_buffer()
        return_dictionary = create_dictionary (temp_string)
        
        print return_dictionary
        self.send_header('Content-Type:', 'application/json; charset=UTF-8')
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'POST,GET')
        self.send_header('Access-Control-Max-Age', '1728000')   

        self.end_headers()
        json_to_send = json.dumps(return_dictionary)

        f.write("REC: " + getTime() + "; " + json_to_send)

        self.wfile.write(json_to_send)


    def do_POST(self):       
        self.send_response(200)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'POST,GET')
        self.send_header('Access-Control-Max-Age', '1728000')
        self.end_headers()   
        print '-> incoming POST'
        content_len = int(self.headers.getheader('content-length'))
        post_body = self.rfile.read(content_len)
        print post_body
        create_wp_file(json.loads(post_body))
        # mavproxy.load_waypoints('wp.txt')

class QuadCopterCommServer(HTTPServer):
    def __init__(self, server_address, RequestHandlerClass):
        print '[initializing server]'
        mavproxy.mavproxy_main()
        self.mpstate = mavproxy.get_mpstate_obj()
        print "[copter link enabled]"
        HTTPServer.__init__(self, server_address, RequestHandlerClass)
 
def create_wp_file(jason):
    default_height = "50.000000" #CHANGE THIS
    stringBuilder = []
    stringBuilder.append("QGC WPL 110\n")
    print len(jason)
    index = 0
    for m in jason:
        stringBuilder.append(str(index) + "\t")
        if index == 0:
            stringBuilder.append("1\t")
        else:
            stringBuilder.append("0\t")
        stringBuilder.append("3\t16\t0.000000\t0.000000\t0.000000\t0.000000\t")
        stringBuilder.append(str(m['lat']) + "\t")
        stringBuilder.append(str(m['lng']) + "\t")
        if index == 0:
            stringBuilder.append("0.000000\t1\n")
        else:
            stringBuilder.append(default_height + "\t1\n")
        index += 1
    file = open ('wp.txt', 'w')
    mainString = ''.join(stringBuilder)
    file.write(mainString)
    file.close()

def create_dictionary(input):
    everything = dict()
    strings = []
    i = 0
    toAppend = False
    for c in input:
        if c == "{":
            strings.append(", ")
            toAppend = True
        elif c == "}":
            toAppend = False
        elif toAppend == True:
            strings.append(c)
        i += 1
    mainString = ''.join(strings)
    lst = mainString.split(", ")
    for thing in lst:
        a = thing.split(":")
        if len(a) == 2: 
          everything[(a[0]).strip()] = (a[1]).strip()
    print everything  
    return_dictionary = dict()
    for a in info_vars:
        return_dictionary[a] = everything[a]
    return return_dictionary
# returns key value pairs of lat lon alt roll pitch yaw

def main():
    try:
        port = DEFAULT_PORT if not sys.argv[1:] else int(sys.argv[1])
        comm_server = QuadCopterCommServer(('', port), QuadCopterCommRequestHandler)
        print "[server started]"
        comm_server.serve_forever()
    except KeyboardInterrupt:
        mavproxy.exit_mavproxy()
        comm_server.socket.close()
        print '[server stopped]'
 
if __name__ == '__main__':
    # child = Popen(['python', 'mavproxy.py'], stdin=PIPE, stdout=PIPE)
    # print(child.communicate('get_info')[0])
    main()
    
