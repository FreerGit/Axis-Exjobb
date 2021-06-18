#include <string.h>
#include "/opt/jansson-2.13.1/include/jansson.h"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <emscripten.h>

#define FS_PREFIX "fs"

static int newline_offset(const char *text)
{
    const char *newline = strchr(text, '\n');
    if(!newline)
        return strlen(text);
    else
        return (int)(newline - text);
}
const char* buildRelativeFilePath(const char* filename) {
	char *path;
	asprintf(&path, "%s/%s", FS_PREFIX, filename);
	return path;
}

int main()
{   
	EM_ASM({
    		var directory = '/' + UTF8ToString($0);
    		FS.mkdir(directory);
    		FS.mount(NODEFS, {root : '.'}, directory);
	}, FS_PREFIX);
    for(int pass = 0; pass < 50; pass++){

    // mount the current folder as a NODEFS instance
	// inside of emscripten

    FILE *f = fopen(buildRelativeFilePath("commits.json"), "rb");
    fseek(f, 0, SEEK_END);
    long fsize = ftell(f);
    fseek(f, 0, SEEK_SET);  /* same as rewind(f); */

    char *string = malloc(fsize + 1);
    fread(string, 1, fsize, f);
    fclose(f);
    
    size_t i;
    char *text = string;
    // char url[URL_SIZE];

    json_t *root;
    json_error_t error;

    root = json_loads(text, 0, &error);
    free(text);

    if(!root)
    {
        fprintf(stderr, "error: on line %d: %s\n", error.line, error.text);
        return 1;
    }
    if(!json_is_array(root))
    {
        fprintf(stderr, "error: root is not an array\n");
        json_decref(root);
        return 1;
    }
    for(i = 0; i < json_array_size(root); i++)
    {
        json_t *data, *sha, *commit, *message;
        const char *message_text;

        data = json_array_get(root, i);
        if(!json_is_object(data))
        {
            fprintf(stderr, "error: commit data %d is not an object\n", i + 1);
            json_decref(root);
            return 1;
        }
            sha = json_object_get(data, "sha");
        if(!json_is_string(sha))
        {
            fprintf(stderr, "error: commit %d: sha is not a string\n", i + 1);
            json_decref(root);
            return 1;
        }

        commit = json_object_get(data, "commit");
        if(!json_is_object(commit))
        {
            fprintf(stderr, "error: commit %d: commit is not an object\n", i + 1);
            json_decref(root);
            return 1;
        }

        message = json_object_get(commit, "message");
        if(!json_is_string(message))
        {
            fprintf(stderr, "error: commit %d: message is not a string\n", i + 1);
            json_decref(root);
            return 1;
        }
        message_text = json_string_value(message);
        printf("%d -> %.8s %.*s\n",
            i+1,
            json_string_value(sha),
            newline_offset(message_text),
            message_text);
    }
    json_decref(root);
    }
    return 0;
}
