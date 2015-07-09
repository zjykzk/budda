#include <stdio.h>

#include "lwan.h"
#include "hredis.h"
#include "conf.h"

static void
bootstart(const char *confPath) {
    loadConf(confPath);
}

static lwan_http_status_t
hello_world(lwan_request_t *request,
            lwan_response_t *response, void *data)
{
    static const char message[] = "Hello, World!";

    response->mime_type = "text/plain";
    strbuf_set_static(response->buffer, message, sizeof(message) - 1);

    return HTTP_OK;
}

int
main(void)
{
    const lwan_url_map_t default_map[] = {
        { .prefix = "/", .handler = hello_world },
        { .prefix = NULL }
    };
    lwan_t l;

    lwan_init(&l);
    lwan_set_url_map(&l, default_map);
    lwan_main_loop(&l);
    lwan_shutdown(&l);

    return 0;
}
