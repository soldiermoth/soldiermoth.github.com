---
layout: default
---

<!-- # Robert Peck -->
<!-- ![Image](/photos/DSC05218.png) -->

# Contact

{% for social in site.data.social %}
| [{{ social.name }}]({{ social.url }}) |
{%- endfor %}



# Projects
## [Test Video Players](https://soldiermoth.com/bobbys-players/)
A set of video players with simple GUIs for video engineers testing purposes.

## [Paginator](https://github.com/soldiermoth/paginator)
Two companion Chrome Extensions for adding easy navigations to websites with numerical URLs
