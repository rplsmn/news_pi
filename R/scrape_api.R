library(httr2)
req <-
    request("https:///newsapi.org/v2/everything") |>
    req_url_query(
        q = '`"data science"`',
        from = Sys.Date() - 1,
        pageSize = 10,
        apiKey = Sys.getenv("MYTEMPAPIKEY")
    )

resp <- req_perform(req)
res <- resp_body_json(resp)

out_path <- file.path("data", paste0(format(Sys.Date(), "%Y-%m-%d"), ".json"))

jsonlite::write_json(res, out_path)
