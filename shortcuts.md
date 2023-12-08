### TMUX 
| Atajo                   | Acción                                       |
| ----------------------- | -------------------------------------------- |
| **ctrl + a**             | prefix                            |
| **prefix + %**             | panel vertical                            |
| **prefix + "**             | panel horizontal                               |
| **prefix + q**     | cambiar de panel con Nro                             |
| **prefix + z**     | zoom a la panel actual                           |
| **prefix + !**     | convierte panel a ventana                           |
| **prefix + x**     | cierra el panel                           |
| **prefix + s**     | crear una sesion                           |
| **prefix + w**     | vista previa de sesiones                           |
| **prefix + I**     | instalar plugins                         |
| **mod + shift + k**     | mover ventana arriba                         |
| **mod + shift + f**     | pasar ventana a flotante                     |
| **mod + tab**           | cambiar la disposición de las ventanas       |
| **mod + [1-9]**         | cambiar al espacio de trabajo N (1-9)        |
| **mod + shift + [1-9]** | mandar ventana al espacio de trabajo N (1-9) |
| **mod + punto**         | enfocar siguiente monitor                    |
| **mod + coma**          | enfocar monitor previo                       |
| **mod + w**             | cerrar ventana                               |
| **mod + ctrl + r**      | reiniciar gestor de ventana                  |
| **mod + ctrl + q**      | cerrar sesión                                |

##### Comandos en TMUX
Estos son algunos de los comandos:
- Abrir una session
```
tmux attach or
tmux attach -t <nombre de la session>
```
- Crear nueva sesion
```
tmux new -s <nombre de la session>
```
- Listar sesiones
```
tmux ls
```
