library(httr2)
library(jsonlite)
library(logger)

req <-
    request("https:///newsapi.org/v2/everything") |>
    req_url_query(
        q = '`"data science"`',
        from = Sys.Date()-12,
        pageSize = 10,
        apiKey = Sys.getenv("MYTEMPAPIKEY")
    )

resp <- req_perform(req)

res <- resp_body_json(resp)

result_size <- length(res$articles)

log_info("Result is of size : {result_size}")

log_info("API response received")

out_path <- file.path("data", paste0(format(Sys.Date(), "%Y-%m-%d"), ".json"))

log_info("Out path created : ")

log_info(out_path)

log_info("Writing to file")

file.create(out_path)

jsonlite::write_json(res, out_path)

log_info("End - clean up")
