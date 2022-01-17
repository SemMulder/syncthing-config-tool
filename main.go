package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"os"

	"github.com/syncthing/syncthing/lib/config"
	"github.com/syncthing/syncthing/lib/protocol"
)

var inTypePtr = flag.String("in-type", "json", "The type of the input config [xml/json].")
var outTypePtr = flag.String("out-type", "xml", "The type of the output config [xml/json].")
var deviceIdPtr = flag.String("device-id", "", "The device id of the device the config belongs to.")

func main() {
	flag.Parse()

	if *inTypePtr != "xml" && *inTypePtr != "json" {
		_, _ = fmt.Fprintf(os.Stderr, "input type should be either 'xml' or 'json' but found: %s\n", *inTypePtr)
		os.Exit(1)
	}

	if *outTypePtr != "xml" && *outTypePtr != "json" {
		_, _ = fmt.Fprintf(os.Stderr, "output type should be either 'xml' or 'json' but found: %s\n", *outTypePtr)
		os.Exit(1)
	}

	deviceId, err := protocol.DeviceIDFromString(*deviceIdPtr)
	if err != nil {
		_, _ = fmt.Fprintf(os.Stderr, "invalid device id %s: %s\n", *deviceIdPtr, err)
		os.Exit(1)
	}

	var cfg config.Configuration
	if *inTypePtr == "json" {
		cfg, err = config.ReadJSON(os.Stdin, deviceId)
		if err != nil {
			_, _ = fmt.Fprintf(os.Stderr, "invalid config passed: %s", err)
			os.Exit(1)
		}
	} else if *inTypePtr == "xml" {
		cfg, _, err = config.ReadXML(os.Stdin, deviceId)
		if err != nil {
			_, _ = fmt.Fprintf(os.Stderr, "invalid config passed: %s", err)
			os.Exit(1)
		}
	} else {
		panic("invalid input type")
	}

	if *outTypePtr == "json" {
		bs, err := json.MarshalIndent(cfg, "", "  ")
		if err != nil {
			_, _ = fmt.Fprintf(os.Stderr, "error serializing config: %s", err)
			os.Exit(1)
		}
		fmt.Printf("%s\n", bs)
	} else if *outTypePtr == "xml" {
		err = cfg.WriteXML(os.Stdout)
		if err != nil {
			_, _ = fmt.Fprintf(os.Stderr, "error serializing config: %s", err)
			os.Exit(1)
		}
	} else {
		panic("invalid output type")
	}
}
