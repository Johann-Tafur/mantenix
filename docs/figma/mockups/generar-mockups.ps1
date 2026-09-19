# Genera los mockups SVG de Mantenix (1440x900) con la misma paleta/tipografia del archivo de Figma.
# Uso (PowerShell):  .\generar-mockups.ps1     -> escribe los .svg en esta misma carpeta.
# Los datos mostrados salen de database/seed.sql (mismos clientes, vehiculos, ordenes, precios y stock).
$ErrorActionPreference = 'Stop'
$out = $PSScriptRoot
$C = @{ p900='#1E3A8A'; p600='#2563EB'; p50='#EFF6FF'; n900='#111827'; n700='#374151'; n500='#6B7280'; n300='#D1D5DB'; n100='#F3F4F6'; w='#FFFFFF'; bg='#F9FAFB'; red='#EF4444' }
$STAT = @{ 'Pendiente'='#F59E0B'; 'Asignada'='#3B82F6'; 'En proceso'='#8B5CF6'; 'Finalizada'='#14B8A6'; 'Entregada'='#22C55E'; 'Cancelada'='#EF4444'; 'Al día'='#22C55E'; 'Próximo'='#F59E0B'; 'Vencido'='#EF4444'; 'Activo'='#22C55E'; 'Stock OK'='#22C55E'; 'Bajo stock'='#EF4444'; 'Automóvil'='#6B7280' }
$FONT = "Inter, 'Segoe UI', Arial, sans-serif"
$es = [Globalization.CultureInfo]::GetCultureInfo('es-CO')

function Esc($s) { [System.Security.SecurityElement]::Escape([string]$s) }
function Mon($n) { '$' + ([double]$n).ToString('N0', $es) }
function Tx($x, $y, $s, $size = 14, $wt = 400, $fill = $C.n900, $anchor = 'start') {
  "<text x=`"$x`" y=`"$y`" font-family=`"$FONT`" font-size=`"$size`" font-weight=`"$wt`" fill=`"$fill`" text-anchor=`"$anchor`">$(Esc $s)</text>"
}
function Rc($x, $y, $w, $h, $fill, $stroke = 'none', $rx = 0, $op = 1) {
  "<rect x=`"$x`" y=`"$y`" width=`"$w`" height=`"$h`" rx=`"$rx`" fill=`"$fill`" fill-opacity=`"$op`" stroke=`"$stroke`"/>"
}
function Ln($x1, $y1, $x2, $y2, $col = $C.n100) { "<line x1=`"$x1`" y1=`"$y1`" x2=`"$x2`" y2=`"$y2`" stroke=`"$col`"/>" }
function Circ($cx, $cy, $r, $fill, $stroke = 'none') { "<circle cx=`"$cx`" cy=`"$cy`" r=`"$r`" fill=`"$fill`" stroke=`"$stroke`" stroke-width=`"2`"/>" }
function BW($label) { [int](18 + 6.6 * $label.Length) }
function Bdg($x, $y, $label) {
  $col = $STAT[$label]; $w = BW $label
  (Rc $x $y $w 22 $col 'none' 11 0.14) + (Tx ($x + $w / 2) ($y + 15) $label 12 500 $col 'middle')
}
function Btn($x, $y, $w, $label, $v = 'primary') {
  $cx = $x + $w / 2
  switch ($v) {
    'primary'   { (Rc $x $y $w 38 $C.p600 'none' 8) + (Tx $cx ($y + 24) $label 14 500 $C.w 'middle') }
    'secondary' { (Rc $x $y $w 38 $C.w $C.n300 8) + (Tx $cx ($y + 24) $label 14 500 $C.n900 'middle') }
    'danger'    { (Rc $x $y $w 38 $C.w $C.red 8) + (Tx $cx ($y + 24) $label 14 500 $C.red 'middle') }
    'ghost'     { Tx $cx ($y + 24) $label 14 500 $C.p600 'middle' }
  }
}
function Inp($x, $y, $w, $label, $val, $muted = $false) {
  $col = if ($muted) { $C.n500 } else { $C.n900 }
  (Tx $x ($y + 12) $label 12 500 $C.n700) + (Rc $x ($y + 20) $w 40 $C.w $C.n300 8) + (Tx ($x + 12) ($y + 45) $val 14 400 $col)
}
function Chk($x, $y, $on) {
  if ($on) { (Rc $x $y 18 18 $C.p600 'none' 4) + "<path d=`"M$($x+4) $($y+9) l3.5 3.5 l7 -7`" fill=`"none`" stroke=`"#FFFFFF`" stroke-width=`"2`" stroke-linecap=`"round`" stroke-linejoin=`"round`"/>" }
  else { Rc $x $y 18 18 $C.w $C.n300 4 }
}
function Card($x, $y, $w, $h) { Rc $x $y $w $h $C.w $C.n300 12 }

function Shell($active, $title, $sub, $user, $role) {
  $s = @()
  $s += (Rc 0 0 1440 900 $C.bg)
  $s += (Rc 0 0 260 900 $C.w $C.n300)
  $s += (Tx 26 44 'Mantenix' 20 700 $C.p900)
  $nav = 'Dashboard', 'Órdenes de trabajo', 'Clientes', 'Vehículos', 'Catálogo y repuestos', 'Reportes', 'Usuarios'
  for ($i = 0; $i -lt $nav.Count; $i++) {
    $y = 72 + $i * 41; $on = ($nav[$i] -eq $active)
    if ($on) { $s += (Rc 16 $y 228 37 $C.p50 'none' 8) }
    $s += (Circ 31 ($y + 18.5) 3 $(if ($on) { $C.p600 } else { $C.n300 }))
    $s += (Tx 46 ($y + 23) $nav[$i] 14 $(if ($on) { 600 } else { 400 }) $(if ($on) { $C.p600 } else { $C.n700 }))
  }
  $s += (Rc 260 0 1180 72 $C.w 'none')
  $s += (Ln 260 72 1440 72 $C.n300)
  $s += (Tx 292 32 $title 18 600 $C.n900)
  $s += (Tx 292 52 $sub 12 400 $C.n500)
  $s += (Circ 1392 36 16 $C.p600)
  $s += (Tx 1368 32 $user 13 500 $C.n900 'end')
  $s += (Tx 1368 48 $role 11 400 $C.n500 'end')
  $s -join "`n"
}

# Tabla generica. $cols: @(etiqueta, x, ancla, peso, color). Celdas: texto, @{badge='..'} o @{link='..'}
function Tbl($x, $y, $w, $cols, $rows, $rh = 46, $hh = 40) {
  $h = $hh + $rows.Count * $rh
  $s = @((Card $x $y $w $h))
  $s += "<path d=`"M$($x+1) $($y+$hh) V$($y+12) a11 11 0 0 1 11 -11 H$($x+$w-12) a11 11 0 0 1 11 11 V$($y+$hh) Z`" fill=`"$($C.n100)`"/>"
  foreach ($cl in $cols) { $s += (Tx $cl[1] ($y + 25) $cl[0] 12 600 $C.n500 $cl[2]) }
  for ($i = 0; $i -lt $rows.Count; $i++) {
    $ry = $y + $hh + $i * $rh
    if ($i -gt 0) { $s += (Ln ($x + 1) $ry ($x + $w - 1) $ry) }
    for ($j = 0; $j -lt $cols.Count; $j++) {
      $cl = $cols[$j]; $cell = $rows[$i][$j]; $ty = $ry + $rh / 2 + 5
      $wt = if ($cl.Count -gt 3) { $cl[3] } else { 400 }
      $co = if ($cl.Count -gt 4) { $cl[4] } else { $C.n700 }
      if ($cell -is [hashtable] -and $cell.badge) { $s += (Bdg $cl[1] ($ry + $rh / 2 - 11) $cell.badge) }
      elseif ($cell -is [hashtable] -and $cell.link) { $s += (Tx $cl[1] $ty $cell.link 13 500 $C.p600 $cl[2]) }
      else { $s += (Tx $cl[1] $ty $cell 13 $wt $co $cl[2]) }
    }
  }
  $s -join "`n"
}

function Svg($name, $body) {
  $svg = "<svg xmlns=`"http://www.w3.org/2000/svg`" width=`"1440`" height=`"900`" viewBox=`"0 0 1440 900`">`n$body`n</svg>`n"
  [System.IO.File]::WriteAllText((Join-Path $out $name), $svg, (New-Object System.Text.UTF8Encoding($false)))
  Write-Host "OK  $name"
}

# ============================ 02 Dashboard ============================
$b = @((Shell 'Dashboard' 'Panel general' 'Resumen de la operación del taller' 'Johann Tafur' 'Administrador'))
$k = @(@('Órdenes pendientes', '1'), @('Órdenes asignadas', '2'), @('Órdenes en proceso', '2'), @('Ingresos (órdenes entregadas)', (Mon 1471000)))
for ($i = 0; $i -lt 4; $i++) {
  $x = 292 + $i * 283
  $b += (Card $x 104 267 94); $b += (Tx ($x + 20) 134 $k[$i][0] 12 500 $C.n500); $b += (Tx ($x + 20) 172 $k[$i][1] 24 700 $C.n900)
}
$b += (Card 292 222 700 340); $b += (Tx 312 254 'Órdenes recientes' 16 600)
$ord = @(
  @('OT-2026-0011', 'Jorge Salazar — JIS789', 'Sin asignar', 'Pendiente'),
  @('OT-2026-0009', 'Transportes El Dorado — TED002', 'Fabián Pineda', 'Asignada'),
  @('OT-2026-0010', 'Sandra Zapata — SMZ679', 'Andrés Muñoz', 'Asignada'),
  @('OT-2026-0007', 'Distribuidora La Sabana — DLS010', 'Andrés Muñoz', 'En proceso'),
  @('OT-2026-0008', 'Juan Pablo Herrera — JPH345', 'Kevin Bermúdez', 'En proceso'))
for ($i = 0; $i -lt 5; $i++) {
  $y = 274 + $i * 56
  if ($i -gt 0) { $b += (Ln 312 $y 972 $y) }
  $b += (Tx 312 ($y + 32) $ord[$i][0] 13 500); $b += (Tx 430 ($y + 32) $ord[$i][1] 13 400 $C.n700)
  $b += (Tx 740 ($y + 32) $ord[$i][2] 13 400 $C.n500); $b += (Bdg 880 ($y + 21) $ord[$i][3])
}
$b += (Card 1016 222 392 340); $b += (Tx 1036 254 'Próximos mantenimientos' 16 600)
$pm = @(@('AFG123 — Chevrolet Spark GT', 'Cambio de aceite · en 5.000 km / 6 meses'), @('CER567 — Yamaha FZ 2.0', 'Cambio de aceite · en 5.000 km / 6 meses'), @('MCR456 — Renault Sandero', 'Cambio de aceite · en 5.000 km / 6 meses'))
for ($i = 0; $i -lt 3; $i++) {
  $y = 284 + $i * 64
  $b += (Tx 1036 ($y + 6) $pm[$i][0] 13 500); $b += (Tx 1036 ($y + 26) $pm[$i][1] 12 400 $C.n500); $b += (Bdg 1316 ($y - 8) 'Al día')
}
$b += (Tx 1036 500 'Se marcan Próximo (≤15 días o ≤500 km) o Vencido.' 12 400 $C.n500)
$b += (Tx 292 594 'Repuestos con stock bajo: 0' 13 500 $C.n700)
Svg '02-dashboard.svg' ($b -join "`n")

# ============================ 03 Clientes ============================
$b = @((Shell 'Clientes' 'Clientes' 'Gestiona los clientes registrados en el taller' 'Valentina Rojas' 'Recepcionista'))
$b += (Rc 292 104 360 40 $C.w $C.n300 8); $b += (Tx 304 129 'Buscar por nombre, documento o teléfono...' 14 400 $C.n500)
$b += (Btn 1258 105 150 '+ Nuevo cliente')
$cols = @(@('Cliente', 312, 'start', 500, $C.n900), @('Documento', 600, 'start'), @('Teléfono', 790, 'start'), @('Vehículos', 950, 'start'), @('Última visita', 1060, 'start', 400, $C.n500), @('', 1388, 'end'))
$rows = @(
  @('Andrés Felipe Gómez Restrepo', 'CC 1035467890', '3201112233', '1', '10 jun 2026', @{link='Ver ficha'}),
  @('María Camila Rodríguez Pérez', 'CC 1098234567', '3202223344', '1', '15 jun 2026', @{link='Ver ficha'}),
  @('Transportes El Dorado S.A.S.', 'NIT 900123456-1', '3157894561', '3', '13 sep 2026', @{link='Ver ficha'}),
  @('Jorge Iván Salazar Muñoz', 'CC 79876543', '3178965412', '1', '14 sep 2026', @{link='Ver ficha'}),
  @('Luisa Fernanda Ortiz Vélez', 'CC 43567890', '3189632587', '1', '5 sep 2026', @{link='Ver ficha'}),
  @('Carlos Eduardo Ramírez Toro', 'CC 15678234', '3196547823', '1', '20 jul 2026', @{link='Ver ficha'}),
  @('Diana Patricia López Cárdenas', 'CC 52789456', '3167894523', '1', '8 sep 2026', @{link='Ver ficha'}),
  @('Distribuidora La Sabana Ltda.', 'NIT 800456789-2', '3125896347', '2', '12 sep 2026', @{link='Ver ficha'}))
$b += (Tbl 292 164 1116 $cols $rows)
$b += (Tx 292 600 'Mostrando 1–8 de 10 clientes' 12 400 $C.n500)
$b += (Btn 1226 584 90 'Anterior' 'secondary'); $b += (Btn 1326 584 82 'Siguiente' 'secondary')
Svg '03-clientes.svg' ($b -join "`n")

# ============================ 04 Vehiculo ============================
$b = @((Shell 'Vehículos' 'Vehículo AFG123' 'Ficha técnica e historial de mantenimiento' 'Valentina Rojas' 'Recepcionista'))
$b += (Card 292 104 1116 88); $b += (Tx 316 146 'AFG123' 24 700); $b += (Tx 316 172 'Chevrolet Spark GT · 2019' 14 400 $C.n500)
$b += (Bdg 470 130 'Automóvil'); $b += (Btn 1116 129 90 'Editar' 'secondary'); $b += (Btn 1218 129 170 'Crear nueva orden')
$cw = 361
$b += (Card 292 212 $cw 112); $b += (Tx 312 240 'Cliente dueño' 12 500 $C.n500); $b += (Tx 312 266 'Andrés Felipe Gómez Restrepo' 15 600)
$b += (Tx 312 288 'CC 1035467890' 13 400 $C.n700); $b += (Tx 312 308 '3201112233 · andres.gomez.cliente@gmail.com' 12 400 $C.n500)
$b += (Card 669 212 $cw 112); $b += (Tx 689 240 'Kilometraje actual' 12 500 $C.n500); $b += (Tx 689 280 '41.800 km' 28 700)
$b += (Tx 689 306 'Actualizado al entregar la orden OT-2026-0001' 12 400 $C.n500)
$b += (Card 1046 212 $cw 112); $b += (Tx 1066 240 'Próximo mantenimiento' 12 500 $C.n500); $b += (Tx 1066 266 'Cambio de aceite y filtro' 15 600)
$b += (Tx 1066 288 'Hacia el 19 mar 2027 o 46.800 km' 13 400 $C.n700); $b += (Bdg 1066 298 'Al día')
$b += (Tx 292 356 'Historial de mantenimientos' 16 600)
$cols = @(@('Orden', 312, 'start', 500, $C.n900), @('Fecha', 430, 'start'), @('Servicios realizados', 560, 'start'), @('Km', 900, 'start'), @('Técnico', 990, 'start'), @('Costo total', 1140, 'start', 500, $C.n900), @('Estado', 1290, 'start'))
$rows = @( ,@('OT-2026-0001', '10 jun 2026', 'Cambio de aceite y filtro, Rotación de llantas', '41.800', 'Andrés Muñoz', (Mon 433000), @{badge='Entregada'}) )
$b += (Tbl 292 372 1116 $cols $rows)
$b += (Tx 292 500 'Próximos mantenimientos' 16 600)
$cols = @(@('Servicio', 312, 'start', 500, $C.n900), @('Fecha sugerida', 600, 'start'), @('Km sugerido', 780, 'start'), @('Faltan', 930, 'start'), @('Estado', 1290, 'start'))
$rows = @(
  @('Cambio de aceite y filtro', '19 mar 2027', '46.800 km', '5.000 km', @{badge='Al día'}),
  @('Rotación de llantas', '19 mar 2027', '51.800 km', '10.000 km', @{badge='Al día'}))
$b += (Tbl 292 516 1116 $cols $rows)
Svg '04-vehiculo-ficha.svg' ($b -join "`n")

# ============================ 05 Crear orden ============================
$b = @((Shell 'Órdenes de trabajo' 'Nueva orden de trabajo' 'Registra el ingreso del vehículo y los servicios a realizar' 'Valentina Rojas' 'Recepcionista'))
$b += (Card 292 104 700 560); $b += (Tx 316 138 'Datos de la orden' 16 600)
$b += (Inp 316 156 652 'Vehículo (buscar por placa)' 'AFG123 — Chevrolet Spark GT')
$b += (Inp 316 236 310 'Kilometraje de ingreso' '41.800'); $b += (Inp 658 236 310 'Técnico asignado (opcional)' 'Sin asignar' $true)
$b += (Tx 316 344 'Servicios a realizar' 14 600)
$sv = @(@('Cambio de aceite y filtro', 120000, $true), @('Rotación de llantas', 35000, $true), @('Alineación y balanceo', 80000, $false), @('Cambio de filtro de aire', 45000, $false), @('Cambio de pastillas de freno', 150000, $false), @('Cambio de líquido de frenos', 60000, $false))
for ($i = 0; $i -lt 6; $i++) {
  $y = 360 + $i * 44
  $b += (Ln 316 $y 968 $y); $b += (Chk 316 ($y + 13) $sv[$i][2]); $b += (Tx 348 ($y + 27) $sv[$i][0] 14 400); $b += (Tx 968 ($y + 27) (Mon $sv[$i][1]) 14 400 $C.n700 'end')
}
$b += (Tx 316 640 'Mostrando 6 de 9 servicios activos del catálogo' 12 400 $C.n500)
$b += (Card 1008 104 400 560); $b += (Tx 1032 138 'Resumen' 16 600)
$b += (Tx 1032 166 'Nº de orden' 12 500 $C.n500); $b += (Tx 1384 166 'OT-2026-0013 (se genera al crear)' 13 500 $C.n900 'end')
$b += (Tx 1032 196 'Cliente' 12 500 $C.n500); $b += (Tx 1384 196 'Andrés Felipe Gómez Restrepo' 13 500 $C.n900 'end')
$b += (Tx 1032 226 'Vehículo' 12 500 $C.n500); $b += (Tx 1384 226 'AFG123 · Chevrolet Spark GT' 13 500 $C.n900 'end')
$b += (Tx 1032 256 'Kilometraje' 12 500 $C.n500); $b += (Tx 1384 256 '41.800 km' 13 500 $C.n900 'end')
$b += (Tx 1032 286 'Técnico' 12 500 $C.n500); $b += (Tx 1384 286 'Sin asignar' 13 500 $C.n500 'end')
$b += (Ln 1032 306 1384 306 $C.n300); $b += (Tx 1032 334 'Servicios seleccionados (2)' 13 600)
$b += (Tx 1032 360 'Cambio de aceite y filtro' 13 400 $C.n700); $b += (Tx 1384 360 (Mon 120000) 13 400 $C.n700 'end')
$b += (Tx 1032 384 'Rotación de llantas' 13 400 $C.n700); $b += (Tx 1384 384 (Mon 35000) 13 400 $C.n700 'end')
$b += (Ln 1032 408 1384 408 $C.n300); $b += (Tx 1032 440 'Costo estimado' 14 500); $b += (Tx 1384 444 (Mon 155000) 24 700 $C.n900 'end')
$b += (Tx 1032 476 'Los repuestos se agregan durante la ejecución.' 12 400 $C.n500)
$b += (Btn 1032 584 110 'Cancelar' 'secondary'); $b += (Btn 1234 584 150 'Crear orden')
Svg '05-crear-orden.svg' ($b -join "`n")

# ============================ 06 Detalle de orden ============================
$b = @((Shell 'Órdenes de trabajo' 'Orden OT-2026-0007' 'Detalle, línea de tiempo y acciones' 'Andrés Muñoz' 'Técnico'))
$b += (Card 292 104 1116 96); $b += (Tx 316 146 'OT-2026-0007' 24 700); $b += (Bdg 492 128 'En proceso')
$b += (Tx 316 174 'Chevrolet NHR · DLS010 · Distribuidora La Sabana Ltda.' 14 400 $C.n500)
$b += (Tx 1384 138 'Costo total' 12 500 $C.n500 'end'); $b += (Tx 1384 172 (Mon 235000) 24 700 $C.n900 'end')
$b += (Card 292 220 1116 130); $b += (Tx 316 252 'Línea de tiempo' 16 600)
$steps = @(@('Pendiente', '10 sep · 07:45', 'S. Quintero'), @('Asignada', '10 sep · 07:55', 'S. Quintero'), @('En proceso', '10 sep · 08:15', 'A. Muñoz'), @('Finalizada', 'Pendiente', ''), @('Entregada', 'Pendiente', ''))
for ($i = 0; $i -lt 5; $i++) {
  $cx = 380 + $i * 232; $done = ($i -le 2)
  if ($i -lt 4) { $b += (Ln ($cx + 12) 290 ($cx + 220) 290 $(if ($i -lt 2) { $C.p600 } else { $C.n300 })) }
  if ($done) { $b += (Circ $cx 290 9 $STAT[$steps[$i][0]]) } else { $b += (Circ $cx 290 9 $C.w $C.n300) }
  $b += (Tx $cx 322 $steps[$i][0] 13 $(if ($i -eq 2) { 700 } else { 600 }) $(if ($done) { $C.n900 } else { $C.n500 }) 'middle')
  $b += (Tx $cx 338 ($steps[$i][1] + $(if ($steps[$i][2]) { ' · ' + $steps[$i][2] } else { '' })) 11 400 $C.n500 'middle')
}
$b += (Card 292 370 700 120); $b += (Tx 316 402 'Servicios' 16 600); $b += (Btn 840 386 132 '+ Agregar servicio' 'ghost')
$b += (Tx 316 436 'Cambio de pastillas de freno' 14 400); $b += (Tx 968 436 (Mon 150000) 14 500 $C.n900 'end')
$b += (Card 292 510 700 140); $b += (Tx 316 542 'Repuestos' 16 600); $b += (Btn 840 526 132 '+ Agregar repuesto' 'ghost')
$b += (Tx 316 578 'Repuesto' 12 600 $C.n500); $b += (Tx 700 578 'Cant.' 12 600 $C.n500); $b += (Tx 800 578 'P. unitario' 12 600 $C.n500); $b += (Tx 968 578 'Subtotal' 12 600 $C.n500 'end')
$b += (Ln 316 588 968 588 $C.n300)
$b += (Tx 316 616 'Pastillas de freno traseras (juego)' 14 400); $b += (Tx 700 616 '1' 14 400 $C.n700); $b += (Tx 800 616 (Mon 85000) 14 400 $C.n700); $b += (Tx 968 616 (Mon 85000) 14 500 $C.n900 'end')
$b += (Card 292 670 700 170); $b += (Tx 316 702 'Observaciones técnicas' 16 600)
$b += (Rc 316 718 652 96 $C.bg $C.n300 8)
$b += (Tx 330 744 'Desgaste avanzado en pastillas traseras. Se recomienda revisar' 13 400 $C.n700)
$b += (Tx 330 766 'los discos en la próxima visita.' 13 400 $C.n700)
$b += (Card 1008 370 400 220); $b += (Tx 1032 402 'Detalles' 16 600)
$d = @(@('Técnico', 'Andrés Felipe Muñoz Castaño'), @('Recepción', 'Sebastián Quintero Ávila'), @('Ingreso', '10 sep 2026 · 07:45'), @('Km de ingreso', '60.700 km'))
for ($i = 0; $i -lt 4; $i++) { $y = 434 + $i * 34; $b += (Tx 1032 $y $d[$i][0] 12 500 $C.n500); $b += (Tx 1384 $y $d[$i][1] 13 500 $C.n900 'end') }
$b += (Card 1008 610 400 230); $b += (Tx 1032 642 'Acciones' 16 600)
$b += (Btn 1032 662 352 'Marcar como finalizada'); $b += (Btn 1032 712 352 'Reasignar técnico' 'secondary'); $b += (Btn 1032 762 352 'Cancelar orden' 'danger')
$b += (Tx 1032 826 'Siguiente estado: Finalizada' 12 400 $C.n500)
Svg '06-detalle-orden.svg' ($b -join "`n")

# ============================ 07a Catalogo de servicios ============================
$tabs = { param($active)
  $t = @()
  $t += (Rc 292 104 200 40 $(if ($active -eq 'S') { $C.p50 } else { $C.w }) $C.n300 8)
  $t += (Tx 392 129 'Servicios' 14 $(if ($active -eq 'S') { 600 } else { 400 }) $(if ($active -eq 'S') { $C.p600 } else { $C.n700 }) 'middle')
  $t += (Rc 500 104 200 40 $(if ($active -eq 'R') { $C.p50 } else { $C.w }) $C.n300 8)
  $t += (Tx 600 129 'Repuestos' 14 $(if ($active -eq 'R') { 600 } else { 400 }) $(if ($active -eq 'R') { $C.p600 } else { $C.n700 }) 'middle')
  $t -join "`n" }
$b = @((Shell 'Catálogo y repuestos' 'Catálogo y repuestos' 'Servicios de mantenimiento e inventario' 'Johann Tafur' 'Administrador'))
$b += (& $tabs 'S'); $b += (Btn 1238 105 170 '+ Nuevo servicio')
$cols = @(@('Servicio', 312, 'start', 500, $C.n900), @('Precio base', 690, 'start'), @('Duración', 810, 'start'), @('Intervalo recomendado', 910, 'start'), @('Estado', 1180, 'start'), @('', 1388, 'end'))
$sv = @(
  @('Cambio de aceite y filtro', 120000, '45 min', '5.000 km / 6 meses'), @('Cambio de filtro de aire', 45000, '20 min', '10.000 km / 12 meses'),
  @('Alineación y balanceo', 80000, '60 min', '10.000 km / 6 meses'), @('Cambio de pastillas de freno', 150000, '90 min', '20.000 km / 12 meses'),
  @('Cambio de líquido de frenos', 60000, '40 min', '20.000 km / 24 meses'), @('Revisión y cambio de correa de distribución', 450000, '180 min', '60.000 km / 48 meses'),
  @('Cambio de batería', 280000, '30 min', '— / 24 meses'), @('Cambio de bujías', 90000, '50 min', '30.000 km / 24 meses'), @('Rotación de llantas', 35000, '30 min', '10.000 km / 6 meses'))
$rows = @(); foreach ($r in $sv) { $rows += , @($r[0], (Mon $r[1]), $r[2], $r[3], @{badge='Activo'}, @{link='Editar'}) }
$b += (Tbl 292 164 1116 $cols $rows 44 40)
Svg '07a-catalogo-servicios.svg' ($b -join "`n")

# ============================ 07b Inventario de repuestos ============================
$b = @((Shell 'Catálogo y repuestos' 'Catálogo y repuestos' 'Servicios de mantenimiento e inventario' 'Johann Tafur' 'Administrador'))
$b += (& $tabs 'R'); $b += (Btn 1238 105 170 '+ Nuevo repuesto')
$cols = @(@('Código', 312, 'start', 500, $C.n900), @('Repuesto', 460, 'start'), @('Precio unitario', 800, 'start'), @('Stock actual', 940, 'start', 500, $C.n900), @('Stock mínimo', 1060, 'start'), @('Estado', 1180, 'start'), @('', 1388, 'end'))
$rp = @(
  @('FLT-ACE-001', 'Filtro de aceite', 18000, 38, 10), @('ACE-15W40-001', 'Aceite motor 15W40 (galón)', 65000, 52, 15), @('FLT-AIR-001', 'Filtro de aire', 32000, 30, 8),
  @('PAST-FRE-DEL', 'Pastillas de freno delanteras (juego)', 95000, 19, 5), @('PAST-FRE-TRA', 'Pastillas de freno traseras (juego)', 85000, 19, 5), @('LIQ-FRE-001', 'Líquido de frenos DOT4 (litro)', 28000, 23, 6),
  @('BAT-12V-001', 'Batería 12V 45Ah', 320000, 10, 3), @('BUJ-IRID-001', 'Bujía de iridio (unidad)', 22000, 49, 12), @('CORR-DIST-001', 'Correa de distribución', 180000, 7, 3),
  @('LLAN-185-65', 'Llanta 185/65 R15', 310000, 16, 4), @('FLT-COMB-001', 'Filtro de combustible', 38000, 22, 6), @('AMORT-DEL-001', 'Amortiguador delantero (unidad)', 210000, 10, 3))
$rows = @(); foreach ($r in $rp) { $est = if ($r[3] -le $r[4]) { 'Bajo stock' } else { 'Stock OK' }; $rows += , @($r[0], $r[1], (Mon $r[2]), "$($r[3])", "$($r[4])", @{badge=$est}, @{link='Editar'}) }
$b += (Tbl 292 164 1116 $cols $rows 40 40)
$b += (Tx 292 704 'Mostrando 12 de 15 repuestos · las filas con stock actual ≤ stock mínimo se marcan en rojo como "Bajo stock" (HU-022).' 12 400 $C.n500)
Svg '07b-inventario-repuestos.svg' ($b -join "`n")

# ============================ 08 Listado de ordenes ============================
$b = @((Shell 'Órdenes de trabajo' 'Órdenes de trabajo' 'Seguimiento del flujo de trabajo del taller' 'Valentina Rojas' 'Recepcionista'))
foreach ($f in @(@(292, 190, 'Estado: Todos'), @(494, 190, 'Técnico: Todos'), @(696, 260, 'Fechas: 1 jun – 19 sep 2026'))) {
  $b += (Rc $f[0] 104 $f[1] 40 $C.w $C.n300 8); $b += (Tx ($f[0] + 12) 129 $f[2] 14 400 $C.n700); $b += (Tx ($f[0] + $f[1] - 16) 129 '▾' 12 400 $C.n500 'end')
}
$b += (Btn 1258 105 150 '+ Nueva orden')
$cols = @(@('Orden', 312, 'start', 500, $C.n900), @('Cliente · vehículo', 450, 'start'), @('Técnico', 800, 'start'), @('Ingreso', 940, 'start', 400, $C.n500), @('Costo', 1040, 'start', 500, $C.n900), @('Estado', 1170, 'start'), @('', 1388, 'end'))
$ord = @(
  @('OT-2026-0001', 'Andrés Felipe Gómez Restrepo · AFG123', 'Andrés Muñoz', '10 jun', 433000, 'Entregada'),
  @('OT-2026-0002', 'María Camila Rodríguez Pérez · MCR456', 'Kevin Bermúdez', '15 jun', 398000, 'Entregada'),
  @('OT-2026-0003', 'Transportes El Dorado S.A.S. · TED001', 'Fabián Pineda', '2 jul', 361000, 'Entregada'),
  @('OT-2026-0004', 'Carlos Eduardo Ramírez Toro · CER567', 'Andrés Muñoz', '20 jul', 279000, 'Entregada'),
  @('OT-2026-0005', 'Luisa Fernanda Ortiz Vélez · LFO234', 'Kevin Bermúdez', '5 sep', 80000, 'Finalizada'),
  @('OT-2026-0006', 'Diana Patricia López Cárdenas · DPL890', 'Fabián Pineda', '8 sep', 695000, 'Finalizada'),
  @('OT-2026-0007', 'Distribuidora La Sabana Ltda. · DLS010', 'Andrés Muñoz', '10 sep', 235000, 'En proceso'),
  @('OT-2026-0008', 'Juan Pablo Herrera Duque · JPH345', 'Kevin Bermúdez', '12 sep', 167000, 'En proceso'),
  @('OT-2026-0009', 'Transportes El Dorado S.A.S. · TED002', 'Fabián Pineda', '13 sep', 45000, 'Asignada'),
  @('OT-2026-0010', 'Sandra Milena Zapata Ríos · SMZ679', 'Andrés Muñoz', '13 sep', 80000, 'Asignada'),
  @('OT-2026-0011', 'Jorge Iván Salazar Muñoz · JIS789', 'Sin asignar', '14 sep', 280000, 'Pendiente'),
  @('OT-2026-0012', 'Sandra Milena Zapata Ríos · SMZ678', 'Sin asignar', '1 sep', 150000, 'Cancelada'))
$rows = @(); foreach ($r in $ord) { $rows += , @($r[0], $r[1], $r[2], $r[3], (Mon $r[4]), @{badge=$r[5]}, @{link='Ver'}) }
$b += (Tbl 292 164 1116 $cols $rows 40 40)
$b += (Tx 292 704 'Mostrando 12 de 12 órdenes' 12 400 $C.n500)
Svg '08-ordenes-listado.svg' ($b -join "`n")


# ============================ 09 Reportes ============================
$b = @((Shell 'Reportes' 'Reportes' 'Servicios más realizados y desempeño por técnico' 'Johann Tafur' 'Administrador'))
$b += (Rc 292 104 300 40 $C.w $C.n300 8); $b += (Tx 304 129 'Rango: 1 jun – 19 sep 2026' 14 400 $C.n700)
$b += (Btn 1268 105 140 'Exportar CSV' 'secondary')
$b += (Card 292 164 700 470); $b += (Tx 316 198 'Servicios más realizados' 16 600)
$b += (Tx 780 198 'Veces' 12 600 $C.n500 'end'); $b += (Tx 968 198 'Ingresos' 12 600 $C.n500 'end')
$rep = @(@('Cambio de aceite y filtro', 4, 480000), @('Cambio de pastillas de freno', 2, 300000), @('Alineación y balanceo', 2, 160000), @('Revisión y cambio de correa de distribución', 1, 450000), @('Cambio de batería', 1, 280000), @('Cambio de bujías', 1, 90000), @('Cambio de líquido de frenos', 1, 60000), @('Cambio de filtro de aire', 1, 45000), @('Rotación de llantas', 1, 35000))
for ($i = 0; $i -lt 9; $i++) {
  $y = 214 + $i * 44
  $b += (Tx 316 ($y + 25) $rep[$i][0] 13 400 $C.n700)
  $b += (Rc 600 ($y + 12) (30 * $rep[$i][1]) 8 $C.p600 'none' 4)
  $b += (Tx 780 ($y + 25) "$($rep[$i][1])" 13 500 $C.n900 'end'); $b += (Tx 968 ($y + 25) (Mon $rep[$i][2]) 13 500 $C.n900 'end')
}
$b += (Tx 316 620 'Excluye órdenes canceladas.' 12 400 $C.n500)
$b += (Card 1008 164 400 470); $b += (Tx 1032 198 'Desempeño por técnico' 16 600)
$tec = @(@('Andrés Felipe Muñoz Castaño', '2 de 4 órdenes terminadas', '1 h 43 min', 103), @('Kevin Santiago Bermúdez Ospina', '2 de 3 órdenes terminadas', '1 h 8 min', 68), @('Fabián Alexander Pineda Gil', '2 de 3 órdenes terminadas', '4 h 0 min', 240))
for ($i = 0; $i -lt 3; $i++) {
  $y = 222 + $i * 128
  $b += (Tx 1032 ($y + 8) $tec[$i][0] 14 600); $b += (Tx 1032 ($y + 30) $tec[$i][1] 13 400 $C.n700)
  $b += (Tx 1032 ($y + 56) 'Tiempo promedio de ejecución' 12 500 $C.n500); $b += (Tx 1384 ($y + 56) $tec[$i][2] 13 600 $C.n900 'end')
  $b += (Rc 1032 ($y + 66) 352 8 $C.n100 'none' 4); $b += (Rc 1032 ($y + 66) ([int](352 * $tec[$i][3] / 240)) 8 $C.p600 'none' 4)
  if ($i -lt 2) { $b += (Ln 1032 ($y + 100) 1384 ($y + 100) $C.n300) }
}
Svg '09-reportes.svg' ($b -join "`n")

# ============================ 10 Usuarios ============================
$b = @((Shell 'Usuarios' 'Usuarios internos' 'Solo visible para el rol Administrador' 'Johann Tafur' 'Administrador'))
$b += (Rc 292 104 360 40 $C.w $C.n300 8); $b += (Tx 304 129 'Buscar por nombre o correo...' 14 400 $C.n500)
$b += (Btn 1238 105 170 '+ Nuevo usuario')
$cols = @(@('Nombre', 312, 'start', 500, $C.n900), @('Correo', 580, 'start'), @('Rol', 880, 'start'), @('Estado', 1010, 'start'), @('', 1388, 'end'))
$rows = @(
  @('Johann Tafur Farfán', 'johanntafurfarfan@gmail.com', 'Administrador', @{badge='Activo'}, @{link='Editar · Desactivar'}),
  @('Carlos Mario Cardona Valderrama', 'carlos.cardona@mantenix.com', 'Administrador', @{badge='Activo'}, @{link='Editar · Desactivar'}),
  @('Valentina Rojas Medina', 'valentina.rojas@mantenix.com', 'Recepcionista', @{badge='Activo'}, @{link='Editar · Desactivar'}),
  @('Sebastián Quintero Ávila', 'sebastian.quintero@mantenix.com', 'Recepcionista', @{badge='Activo'}, @{link='Editar · Desactivar'}),
  @('Andrés Felipe Muñoz Castaño', 'andres.munoz@mantenix.com', 'Técnico', @{badge='Activo'}, @{link='Editar · Desactivar'}),
  @('Kevin Santiago Bermúdez Ospina', 'kevin.bermudez@mantenix.com', 'Técnico', @{badge='Activo'}, @{link='Editar · Desactivar'}),
  @('Fabián Alexander Pineda Gil', 'fabian.pineda@mantenix.com', 'Técnico', @{badge='Activo'}, @{link='Editar · Desactivar'}))
$b += (Tbl 292 164 1116 $cols $rows 46 40)
$b += (Tx 292 540 'Al crear un usuario se genera una contraseña temporal que debe cambiar en su primer ingreso (HU-004).' 12 400 $C.n500)
$b += (Tx 292 560 'Un usuario desactivado no puede iniciar sesión, pero conserva su historial de órdenes (HU-005).' 12 400 $C.n500)
Svg '10-usuarios.svg' ($b -join "`n")

# ============================ 11 Portal del cliente ============================
$b = @()
$b += (Rc 0 0 1440 900 $C.bg); $b += (Rc 0 0 1440 72 $C.w 'none'); $b += (Ln 0 72 1440 72 $C.n300)
$b += (Tx 162 44 'Mantenix' 20 700 $C.p900)
$b += (Circ 1278 36 16 $C.p600); $b += (Tx 1254 32 'Andrés Felipe Gómez' 13 500 $C.n900 'end'); $b += (Tx 1254 48 'Cliente' 11 400 $C.n500 'end')
$b += (Tx 1316 41 'Cerrar sesión' 13 500 $C.p600)
$b += (Tx 162 130 'Hola, Andrés Felipe' 24 700); $b += (Tx 162 156 'Este es el estado de tus vehículos y sus mantenimientos.' 14 400 $C.n500)
$b += (Card 162 184 1116 96); $b += (Tx 186 222 'AFG123' 20 700); $b += (Tx 186 246 'Chevrolet Spark GT · 2019 · Automóvil' 14 400 $C.n500)
$b += (Tx 1254 222 'Kilometraje actual' 12 500 $C.n500 'end'); $b += (Tx 1254 252 '41.800 km' 22 700 $C.n900 'end')
$b += (Tx 162 316 'Mantenimientos programados' 16 600)
$cols = @(@('Servicio', 186, 'start', 500, $C.n900), @('Cuándo', 520, 'start'), @('Faltan', 800, 'start'), @('Estado', 1150, 'start'))
$rows = @(
  @('Cambio de aceite y filtro', '19 mar 2027 o 46.800 km', '5.000 km / 6 meses', @{badge='Al día'}),
  @('Rotación de llantas', '19 mar 2027 o 51.800 km', '10.000 km / 6 meses', @{badge='Al día'}))
$b += (Tbl 162 332 1116 $cols $rows 46 40)
$b += (Tx 162 488 'Verás el aviso "Próximo" 15 días o 500 km antes, y "Vencido" si se supera la fecha o el kilometraje (HU-033).' 12 400 $C.n500)
$b += (Tx 162 532 'Historial de mantenimientos' 16 600)
$cols = @(@('Orden', 186, 'start', 500, $C.n900), @('Fecha', 320, 'start'), @('Servicios', 450, 'start'), @('Costo', 900, 'start', 500, $C.n900), @('Estado', 1150, 'start'))
$rows = @( ,@('OT-2026-0001', '10 jun 2026', 'Cambio de aceite y filtro, Rotación de llantas', (Mon 433000), @{badge='Entregada'}) )
$b += (Tbl 162 548 1116 $cols $rows 46 40)
Svg '11-portal-cliente.svg' ($b -join "`n")

# ============================ 12 Ficha de cliente ============================
$b = @((Shell 'Clientes' 'Transportes El Dorado S.A.S.' 'Ficha del cliente e historial' 'Valentina Rojas' 'Recepcionista'))
$b += (Card 292 104 1116 88); $b += (Tx 316 146 'Transportes El Dorado S.A.S.' 22 700); $b += (Tx 316 172 'NIT 900123456-1 · Última visita: 13 sep 2026' 14 400 $C.n500)
$b += (Btn 1116 129 90 'Editar' 'secondary'); $b += (Btn 1218 129 170 '+ Registrar vehículo')
$b += (Card 292 212 1116 92); $b += (Tx 316 240 'Teléfono' 12 500 $C.n500); $b += (Tx 316 264 '3157894561' 14 500)
$b += (Tx 560 240 'Correo' 12 500 $C.n500); $b += (Tx 560 264 'contacto@transporteseldorado.com' 14 500)
$b += (Tx 960 240 'Dirección' 12 500 $C.n500); $b += (Tx 960 264 'Av. Boyacá # 12-45, Bogotá' 14 500)
$b += (Tx 316 288 'El número de documento no se puede modificar (HU-009).' 12 400 $C.n500)
$b += (Tx 292 340 'Vehículos (3)' 16 600)
$cols = @(@('Placa', 312, 'start', 500, $C.n900), @('Vehículo', 460, 'start'), @('Tipo', 800, 'start'), @('Kilometraje', 950, 'start'), @('', 1388, 'end'))
$rows = @(@('TED001', 'Chevrolet NPR · 2018', 'Camión', '95.200 km', @{link='Ver ficha'}), @('TED002', 'Nissan NP300 · 2020', 'Camioneta', '54.000 km', @{link='Ver ficha'}), @('TED003', 'Chevrolet NPR · 2020', 'Camión', '68.200 km', @{link='Ver ficha'}))
$b += (Tbl 292 356 1116 $cols $rows 44 40)
$b += (Tx 292 568 'Historial de órdenes' 16 600)
$cols = @(@('Orden', 312, 'start', 500, $C.n900), @('Fecha', 460, 'start'), @('Vehículo', 600, 'start'), @('Costo', 800, 'start', 500, $C.n900), @('Estado', 950, 'start'), @('', 1388, 'end'))
$rows = @(@('OT-2026-0009', '13 sep 2026', 'TED002', (Mon 45000), @{badge='Asignada'}, @{link='Ver orden'}), @('OT-2026-0003', '2 jul 2026', 'TED001', (Mon 361000), @{badge='Entregada'}, @{link='Ver orden'}))
$b += (Tbl 292 584 1116 $cols $rows 44 40)
Svg '12-ficha-cliente.svg' ($b -join "`n")

# ============================ 13 y 14 Modales de alta ============================
$b = @((Shell 'Clientes' 'Clientes' 'Gestiona los clientes registrados en el taller' 'Valentina Rojas' 'Recepcionista'))
$b += (Rc 0 0 1440 900 '#111827' 'none' 0 0.45)
$b += (Card 440 170 560 470); $b += (Tx 468 208 'Nuevo cliente' 18 600)
$b += (Inp 468 224 150 'Tipo de documento' 'CC'); $b += (Inp 630 224 342 'Número de documento' '1035467890')
$b += (Inp 468 300 504 'Nombre completo' 'Nombre y apellidos')
$b += (Inp 468 376 246 'Teléfono' '3001234567'); $b += (Inp 726 376 246 'Correo (opcional)' 'correo@ejemplo.com' $true)
$b += (Inp 468 452 504 'Dirección (opcional)' 'Calle 00 # 00-00, Ciudad' $true)
$b += (Btn 468 572 110 'Cancelar' 'secondary'); $b += (Btn 822 572 150 'Guardar cliente')
Svg '13-modal-nuevo-cliente.svg' ($b -join "`n")

$b = @((Shell 'Vehículos' 'Vehículos' 'Registro y consulta de vehículos' 'Valentina Rojas' 'Recepcionista'))
$b += (Rc 0 0 1440 900 '#111827' 'none' 0 0.45)
$b += (Card 440 170 560 470); $b += (Tx 468 208 'Registrar vehículo' 18 600)
$b += (Inp 468 224 504 'Cliente (buscar por nombre o documento)' 'Carlos Eduardo Ramírez Toro · CC 15678234')
$b += (Inp 468 300 246 'Placa' 'ABC123'); $b += (Inp 726 300 246 'Año' '2024')
$b += (Inp 468 376 246 'Marca' 'Yamaha'); $b += (Inp 726 376 246 'Modelo' 'FZ 3.0')
$b += (Inp 468 452 246 'Tipo de vehículo' 'Motocicleta'); $b += (Inp 726 452 246 'Kilometraje actual' '0')
$b += (Btn 468 572 110 'Cancelar' 'secondary'); $b += (Btn 812 572 160 'Guardar vehículo')
Svg '14-modal-nuevo-vehiculo.svg' ($b -join "`n")

# ============================ 15 Mi perfil ============================
$b = @((Shell '' 'Mi perfil' 'Datos de contacto y seguridad de tu cuenta' 'Valentina Rojas' 'Recepcionista'))
$b += (Card 292 104 548 330); $b += (Tx 316 138 'Datos de contacto' 16 600)
$b += (Inp 316 156 500 'Nombre' 'Valentina Rojas Medina'); $b += (Inp 316 236 500 'Teléfono' '3112345678'); $b += (Inp 316 316 500 'Correo' 'valentina.rojas@mantenix.com')
$b += (Tx 316 392 'Si cambias el correo se te pedirá reconfirmarlo.' 12 400 $C.n500); $b += (Btn 666 380 150 'Guardar cambios')
$b += (Card 860 104 548 330); $b += (Tx 884 138 'Cambiar contraseña' 16 600)
$b += (Inp 884 156 500 'Contraseña actual' '••••••••'); $b += (Inp 884 236 500 'Nueva contraseña' '••••••••'); $b += (Inp 884 316 500 'Confirmar nueva contraseña' '••••••••')
$b += (Tx 884 392 'Mínimo 8 caracteres, con letras y números.' 12 400 $C.n500); $b += (Btn 1234 380 150 'Actualizar')
Svg '15-perfil.svg' ($b -join "`n")

# ============================ 16 Recuperar contrasena ============================
$b = @((Rc 0 0 1440 900 $C.bg), (Rc 0 0 640 900 $C.p900))
$b += (Tx 64 430 'Mantenix' 32 700 $C.w); $b += (Tx 64 466 'Gestión de mantenimiento preventivo' 16 400 $C.p50); $b += (Tx 64 490 'para talleres automotrices.' 16 400 $C.p50)
$b += (Tx 820 330 'Recuperar contraseña' 24 700); $b += (Tx 820 358 'Te enviaremos un enlace para crear una nueva contraseña.' 14 400 $C.n500)
$b += (Inp 820 386 360 'Correo electrónico' 'nombre@mantenix.com' $true)
$b += (Btn 820 470 360 'Enviar enlace'); $b += (Tx 1000 540 '← Volver a iniciar sesión' 14 500 $C.p600 'middle')
$b += (Tx 820 580 'El enlace es válido por 30 minutos (HU-003).' 12 400 $C.n500)
Svg '16-recuperar-contrasena.svg' ($b -join "`n")
