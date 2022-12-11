###### pfSense 2.3+ WPAD/PAC proxy configuration guide ####

#Crear archivos de detección de proxy.

#Crearemos el proxy.pacarchivo inicial y luego crearemos dos archivos
'vinculados' a wpad.daty wpad.daarchivos que harán que mantenerlos 
todos sincronizados sea más fácil.

nano /usr/local/www/nginx/proxy.pac
function FindProxyForURL(url,host)
{
  if(isPlainHostName(host))
  {
    return "DIRECT";
  }

  if(isInNet(host,"127.0.0.1","255.255.255.0"))
  {
    return "DIRECT";
  }

  return "PROXY 192.168.1.1:3128";
}


Este archivo PAC verifica si el host que se está buscando es un nombre de host simple,
 es decir, "intranet", o es la red localhost (127.0.0.1), si lo es, el acceso pasa por alto el proxy ("DIRECTO") . Si no se cumple ninguna de las condiciones anteriores, el acceso se realiza a través del proxy y el puerto 3128.

Tengo que hacer estas comprobaciones porque hago algo de desarrollo web y ese desarrollo se prueba en un servidor local y no quiero que pase por mi proxy. Es posible ampliar la funcionalidad del archivo PAC para incluir funciones como listas blancas/negras, etc.

Cree las otras dos variaciones de archivos generando enlaces. Esto es preferible ya que ayuda a mantener todas las versiones sincronizadas si realiza algún cambio en el futuro.


ln -s /usr/local/www/nginx/proxy.pac /usr/local/www/nginx/wpad.dat

ln -s /usr/local/www/nginx/proxy.pac /usr/local/www/nginx/wpad.da

