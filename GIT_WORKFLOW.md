# MyHyDE Git Workflow

## Estructura de ramas

| Rama | Descripción | origen |
|------|------------|--------|
| `master` | Espejo 1:1 del upstream oficial | `upstream/master` |
| `personal` | Tus personalizaciones | `origin/personal` |

**Nunca hacer commit directo en master.** Esta rama es solo para sincronizar con upstream.

---

## Sincronizar con upstream (recibir cambios de HyDE)

### Paso 1: Traer cambios del upstream

```bash
git fetch upstream
```

### Paso 2: Actualizar master

```bash
git checkout master
git merge upstream/master   # fast-forward, sin conflictos
git push origin master
```

### Paso 3: Traer tus cambios a personal

```bash
git checkout personal
git rebase master
```

### Paso 4: Resolver conflictos (si hay)

Si hay conflictos, Git te mostrará los archivos. Resuélvelos manualmente, luego:

```bash
git add <archivos resueltos>
git rebase --continue
```

### Paso 5: Subir cambios

```bash
git push origin personal --force-with-lease
```

---

## Flujo visual

```
Antes de sync:
master:     A---B---C            (upstream)
personal:       A---B---D---E      (tuy)

           git checkout master
           git merge upstream/master

master:         A---B---C---C'    (nuevo upstream + fast-forward)

           git checkout personal
           git rebase master

personal:       A---B---C---C'---D'---E'  (tus commits replantados)
```

---

## Reglas importantes

1. **No usar merge en personal** — usar siempre `rebase` para mantener historial limpio
2. **Usar siempre `--force-with-lease`** — nunca `--force` solo
3. **Master es solo lectura** — nunca hacer commits directamente en master
4. **Antes de rebase, hacer fetch de upstream** — siempre tener la última versión

---

## Atajos útiles

### Ver estado
```bash
git status
git log --oneline -5
```

### Ver diferencias con upstream
```bash
git diff upstream/master master
git diff master personal
```

### Ver qué cambió en personal
```bash
git log master..personal --oneline
```

---

## Comandos completos (copy-paste)

```bash
# Sincronizar todo
git fetch upstream && git checkout master && git merge upstream/master && git push origin master && git checkout personal && git rebase master && git push origin personal --force-with-lease
```

---

## Resolver conflictos

Si-git muestra conflictos durante `git rebase`:

1. Ver los archivos en conflicto:
```bash
git status
```

2. Editar manualmente los conflictos

3. Marcar como resuelto:
```bash
git add <archivo>
```

4. Continuar el rebase:
```bash
git rebase --continue
```

5. Para cancelar y empezar de nuevo:
```bash
git rebase --abort
```

---

## Referencias

- Upstream: `https://github.com/HyDE-Project/HyDE.git`
- Origin (tu fork): `git@github-NA:NelsonAguirre/MyHyDE.git`