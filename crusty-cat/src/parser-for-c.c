#include <string.h>
#include <jansson.h>
#include <stdio.h>

#define btoa(x) ((x) ? "true" : "false")

// Currently unused, cuts of text at certain threshold
static int newline_offset(const char *text)
{
  const char *newline = strchr(text, '\n');
  if (!newline)
    return strlen(text);
  else
    return (int)(newline - text);
}

int main(int argc, char *argv[])
{
  for (int x = 0; x < 50; x++)
  {
    size_t i;
    char *text;

    json_t *root;
    json_error_t error;

    FILE *json = fopen("commits.json", "r");
    if (json)
    {
      long length;
      fseek(json, 0, SEEK_END);
      length = ftell(json);
      fseek(json, 0, SEEK_SET);
      text = malloc(length);
      if (text)
      {
        size_t read = fread(text, 1, length, json);
      }
      fclose(json);
    }

    if (!text)
      return 1;

    root = json_loads(text, 0, &error);
    free(text);

    if (!root)
    {
      fprintf(stderr, "error: on line %d: %s\n", error.line, error.text);
      return 1;
    }

    if (!json_is_array(root))
    {
      printf("error: root is not an array!\n\n");
      json_decref(root);
      return 1;
    }

    for (int i = 0; i < json_array_size(root); i++)
    {
      json_t *data, *sha, *commit, *message;
      const char *message_text;

      data = json_array_get(root, i);
      if (!json_is_object(data))
      {
        fprintf(stderr, "error: commit data %d is not an object\n", i + 1);
        json_decref(root);
        return 1;
      }
      sha = json_object_get(data, "sha");
      if (!json_is_string(sha))
      {
        fprintf(stderr, "error: commit %d: sha is not a string\n", i + 1);
        json_decref(root);
        return 1;
      }

      commit = json_object_get(data, "commit");
      if (!json_is_object(commit))
      {
        fprintf(stderr, "error: commit %d: commit is not an object\n", i + 1);
        json_decref(root);
        return 1;
      }

      message = json_object_get(commit, "message");
      if (!json_is_string(message))
      {
        fprintf(stderr, "error: commit %d: message is not a string\n", i + 1);
        json_decref(root);
        return 1;
      }
      message_text = json_string_value(message);
      printf("%d -> %.8s %.*s\n",
             i + 1,
             json_string_value(sha),
             newline_offset(message_text),
             message_text);
      free(data);
      free(commit);
      free(message);
      free(sha);
    }
    json_decref(root);
  }
  return 0;
}