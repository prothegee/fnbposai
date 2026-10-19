package sql_dummies

import (
	"encoding/json"
	"fmt"
	"os"

	"gorm.io/gorm"
	gormPG "gorm.io/driver/postgres"
)

// --------------------------------------------------------- //

type pgConnection struct {
	Postgres struct {
		Primary struct {
			Dsn string `json:"dsn"`
		} `json:"primary"`
	} `json:"postgres"`
}

// --------------------------------------------------------- //

var sqlFiles = []string{
	"assets/sql/000001_dummy_account.sql",
	"assets/sql/000002_dummy_tenant.sql",
	"assets/sql/000003_dummy_pos.sql",
}

// --------------------------------------------------------- //

func loadPgConnectionConfig(filePath string) (pgConnection, error) {
	var cfg pgConnection

	content, err := os.ReadFile(filePath)
	if err != nil {
		return cfg, err
	}

	err = json.Unmarshal(content, &cfg)
	if err != nil {
		return cfg, err
	}

	return cfg, nil
}

func loadPgConnectionDsn(config pgConnection) string {
	return config.Postgres.Primary.Dsn
}

// --------------------------------------------------------- //

func GenerateDemoDummies() {
	cfg, err := loadPgConnectionConfig("config.json")
	if err != nil {
		fmt.Fprintf(os.Stderr, "ERROR: %v\n", err)
		return
	}

	dsn := loadPgConnectionDsn(cfg)

	db, err := gorm.Open(gormPG.Open(dsn), &gorm.Config{})
	if err != nil {
		fmt.Printf("ERROR gorm: %v\n", err)
		return
	}

	// Generate all sql dummies
	for _, file := range sqlFiles {
		data, err := os.ReadFile(file)
		if err != nil {
			fmt.Fprintf(os.Stderr, "ERROR: %s %v\n", file, err)
			os.Exit(1)
		}
		err = db.Exec(string(data)).Error
		if err != nil {
			fmt.Fprintf(os.Stderr, "ERROR: fail to exec %s %v\n", file, err)
			os.Exit(1)
		}
		fmt.Printf("GENERATE: %s\n", file)
	}
	fmt.Println("TODO: tenant_taxes")
}
