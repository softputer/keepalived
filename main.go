package main

import (
	"fmt"
	"io"
	"text/template"
	"os"
)

func main() {
	var w io.Writer
	var err error
	w, err = os.Create("/etc/keepalived/keepalived.conf")
	if err != nil {
		fmt.Println("Err Create")
	}
	var t *template.Template
	t, err = template.ParseFiles("/etc/keepalived/keepalived_template.cfg")
	conf := make(map[string]interface{})
	var Priority, LocalIP, PeerIP string
	if Priority = os.Getenv("PRIORITY"); len(Priority) == 0 {
		Priority = "100"
        }
 	if LocalIP = os.Getenv("LOCALIP"); len(LocalIP) == 0 {
		LocalIP = "127.0.0.1"
	}
	if PeerIP = os.Getenv("PEERIP"); len(PeerIP) == 0 {
		PeerIP = "127.0.0.1"
	}
	conf["Priority"] = Priority
	conf["LocalIP"] = LocalIP
	conf["PeerIP"] = PeerIP
	err = t.Execute(w, conf)
	if err != nil {
		fmt.Println("Err Done")
	}
}
