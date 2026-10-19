package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"

	"github.com/prothegee/fnbposai/cmd/devtools/dummies"
)

// --------------------------------------------------------- //

func handleGen(args []string) {
	if len(args) < 1 {
		fmt.Println("usage: go run cmd/prog/main.go gen <dummies|...>")
		return
	}

	switch args[0] {
	case "dummies":
		if confirm("WARNING: Generate data dummies for this project?") {
			dummies.GenerateDemoDummies()
		}
	default:
		fmt.Printf("unknown gen target: %q\n", args[0])
		os.Exit(1)
	}
}

func confirm(prompt string) bool {
	fmt.Printf("%s (y/n): ", prompt)
	s := bufio.NewScanner(os.Stdin)
	s.Scan()
	return strings.HasPrefix(strings.ToLower(strings.TrimSpace(s.Text())), "y")
}

// --------------------------------------------------------- //

func main() {
	if len(os.Args) < 2 {
		fmt.Println("usage: go run cmd/prog/main.go <command> [subcommand]")
		return
	}

	switch os.Args[1] {
	case "generate":
		handleGen(os.Args[2:])
	default:
		fmt.Printf("unknown command: %q\n", os.Args[1])
		os.Exit(1)
	}
}
