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
  for (int x = 0; x < 3; x++)
  {
    size_t i;
    char *text;

    json_t *root;
    json_error_t error;

    FILE *json = fopen("tets.json", "r");
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
      json_t *objec, *balance, *name, *gender, *active;
      const char *message_text;
      objec = json_array_get(root, i);
      if (!json_is_object(objec))
      {
        fprintf(stderr, "error: commit data %d is not an object\n", i + 1);
        json_decref(root);
        return 1;
      }

      balance = json_object_get(objec, "balance");
      if (!json_is_string(balance))
      {
        fprintf(stderr, "error: balance is not a string\n");
        json_decref(root);
        return 1;
      }

      name = json_object_get(objec, "name");
      if (!json_is_string(name))
      {
        fprintf(stderr, "error: name is not a string\n");
        json_decref(root);
        return 1;
      }

      gender = json_object_get(objec, "gender");
      if (!json_is_string(gender))
      {
        fprintf(stderr, "error: gender is not a string\n");
        json_decref(root);
        return 1;
      }

      active = json_object_get(objec, "isActive");
      if (!json_is_boolean(active))
      {
        fprintf(stderr, "error: actice is not a boolean\n");
        json_decref(root);
        return 1;
      }

      printf(
          "Name: %s\nGender: %s\nBalance: %s\nIs active: %s\n\n",
          json_string_value(name),
          json_string_value(gender),
          json_string_value(balance),
          btoa(json_boolean_value(active)));
    }
    json_decref(root);
  }
  return 0;
}