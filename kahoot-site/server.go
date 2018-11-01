package main

import (
	"fmt"
	"net/http"
	"os"
	"strings"
	"sync"

	"github.com/unixpickle/kahoot-hack/kahoot"
)

func main() {
	http.HandleFunc("/api/", func(w http.ResponseWriter, r *http.Request) {

		path := strings.Split(r.URL.String(), "/")
		switch path[1] {
		case "":
		}
	})
}

const concurrencyCount = 4

func flood(gamePin string, names string, done chan bool) {
	var dieLock sync.Mutex
	connChan := make(chan *kahoot.Conn)
	for i := 0; i < concurrencyCount; i++ {
		go func() {
			for {
				conn, err := kahoot.NewConn(gamePin)
				if err != nil {
					dieLock.Lock()
					fmt.Fprintln(os.Stderr, "failed to connect:", err)
					os.Exit(1)
					dieLock.Unlock()
				}
				connChan <- conn
			}
		}()
	}

	for _, nickname := range strings.Split(names, " ") {
		conn := <-connChan
		defer conn.GracefulClose()
		conn.Login(nickname)
	}

	<-done
}
