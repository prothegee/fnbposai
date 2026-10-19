package dummies

import (
	"encoding/json"
	"fmt"
	"io"
	"os"
	"path/filepath"

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

var mediaPublicDir = []string{
	"public/a",
	"public/t",
	// account
	"public/a/01a14e6f1b7179e1b42ccfe9c0cbde32",
	// tenant
	"public/t/01a14e6fab5374d4af99f9e541108ba0",
	// tenant branch
	"public/t/01a14e6fab5374d4af99f9e541108ba0/01a14e70c4b670bbb65a899d4a53fc9d",
}

var mediaDummySourceDir = "assets/dummy_media_dir"

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

func copyFile(src, dst string) error {
	in, err := os.Open(src)
	if err != nil {
		return err
	}
	defer in.Close()

	err = os.MkdirAll(filepath.Dir(dst), 0755)
	if err != nil {
		return err
	}

	out, err := os.Create(dst)
	if err != nil {
		return err
	}
	defer out.Close()

	_, err = io.Copy(out, in)
	if err != nil {
		return err
	}

	return nil
}

func copyDir(src, dst string) error {
	return filepath.Walk(src, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		rel, err := filepath.Rel(src, path)
		if err != nil {
			return err
		}

		target := filepath.Join(dst, rel)

		if info.IsDir() {
			return os.MkdirAll(target, 0755)
		}

		return copyFile(path, target)
	})
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

	// Generate public static dir
	// must exactly same with fnbposai-be-media root dir.
	for _, dir := range mediaPublicDir {
		_, err := os.Stat(dir)
		if os.IsNotExist(err) {
			err = os.MkdirAll(dir, 0755)
			if err != nil {
				fmt.Fprintf(os.Stderr, "ERROR: fail to make dir, %v\n", err)
				return
			}
		}
	}

	// Copy static dummy assets
	// must exactly same with fnbposai-be-media root dir.
	err = copyDir(mediaDummySourceDir, "public")
	if err != nil {
		fmt.Fprintf(os.Stderr, "ERROR: fail to copy dummy assets, %v\n", err)
		return
	}
	fmt.Printf("COPY: %s -> public\n", mediaDummySourceDir)
}
