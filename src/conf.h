#ifndef BUDDA_CONF_H
#define BUDDA_CONF_H
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

typedef struct _buddaConf BuddaConf;

struct _buddaConf {
    char *ip;
    short port;
    char *scriptDir;
};

static BuddaConf *G_CONF;

static char *
getStrConf(const lua_State *L, const char *name) {
    lua_getglobal(L, name);
    size_t len;
    const char *ip = lua_tolstring(L, -1, &len);
    if (ip == NULL) return NULL;

    char *ret = malloc(len + 1);
    memcpy(ip, ret, len);
    ret[len] = '\0';
    lua_pop(L, 1);
    return ret;
}

static short
getShortConf(const lua_State *L, const char *name) {
    lua_getglobal(L, name);
    short ret = (short) lua_tointeger(L, -1);
    lua_pop(L, 1);
    return ret;
}

static BuddaConf *
loadConf(const char *confPath) {
    lua_State *L = luaL_newstate();
    luaL_openlibs(L);
    if (luaL_loadfile(L, confPath) || lua_pcall(L, 0, 0, 0)) {
        printf("cannot load config %s\n", confPath);
        return NULL;
    }
    BuddaConf *conf = malloc(sizeof(*conf));
    conf->ip = getStrConf(L, "ip");
    conf->port = getShortConf(L, "port");
    conf->scriptDir = getStrConf(L, "scriptDir");
    lua_close(L);
    G_CONF = conf;
}

static void
freeConf() {
    free(G_CONF->ip);
    free(G_CONF->scriptDir);
    free(G_CONF);
}

#endif // BUDDA_CONF_H
