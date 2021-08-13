package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)

var (
	port = 8080
	hash = NewHash()
)

func main() {
	http.HandleFunc("/", insert)
	fmt.Printf("Listening on port %v.\n", port)
	if err := http.ListenAndServe(fmt.Sprintf(":%v", port), nil); err != nil {
		panic(err)
	}
}

func insert(w http.ResponseWriter, r *http.Request) {
	var ht HText
	err := json.NewDecoder(r.Body).Decode(&ht)
	if err != nil {
		return
	}
	hash.Insert(ht)
}

type HText struct {
	From string `json:"from"`
	URL  string `json:"urL"`
	Text string `json:"text"`
}

type HTexts struct {
	From  string
	URL   string
	Texts []string
}

func (h HTexts) String() string {
	return fmt.Sprintf("From: %v\nURL: %v\nTexts: %v\n", h.From, h.URL, h.Texts)
}

type Hash struct {
	hash map[string]map[string]HTexts
}

func NewHash() *Hash {
	return &Hash{hash: map[string]map[string]HTexts{}}
}

func (h Hash) Get(ht HText) (*HTexts, bool) {
	from, ok := h.hash[ht.From]
	if !ok {
		return nil, false
	}
	result, ok := from[ht.URL]
	if !ok {
		return nil, false
	}
	return &result, true
}

func (h *Hash) Insert(ht HText) bool {
	from, ok := h.hash[ht.From]
	if !ok {
		from := map[string]HTexts{}
		from[ht.URL] = HTexts{
			From: ht.From,
			URL:  ht.URL,
		}
		h.hash[ht.From] = from
	}
	hts := from[ht.URL]
	for _, txt := range hts.Texts {
		if txt == ht.Text {
			return false
		}
	}
	hts.Texts = append(hts.Texts, ht.Text)
	h.hash[ht.From][ht.URL] = hts
	return true
}
