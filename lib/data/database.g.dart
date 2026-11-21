// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AjustesTable extends Ajustes with TableInfo<$AjustesTable, Ajuste> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AjustesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Mi Lavadero'),
  );
  static const VerificationMeta _aliasMeta = const VerificationMeta('alias');
  @override
  late final GeneratedColumn<String> alias = GeneratedColumn<String>(
    'alias',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _valorHoraMeta = const VerificationMeta(
    'valorHora',
  );
  @override
  late final GeneratedColumn<int> valorHora = GeneratedColumn<int>(
    'valor_hora',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, nombre, alias, valorHora];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ajustes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Ajuste> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    }
    if (data.containsKey('alias')) {
      context.handle(
        _aliasMeta,
        alias.isAcceptableOrUnknown(data['alias']!, _aliasMeta),
      );
    }
    if (data.containsKey('valor_hora')) {
      context.handle(
        _valorHoraMeta,
        valorHora.isAcceptableOrUnknown(data['valor_hora']!, _valorHoraMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ajuste map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ajuste(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      alias: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alias'],
      )!,
      valorHora: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}valor_hora'],
      )!,
    );
  }

  @override
  $AjustesTable createAlias(String alias) {
    return $AjustesTable(attachedDatabase, alias);
  }
}

class Ajuste extends DataClass implements Insertable<Ajuste> {
  final int id;
  final String nombre;
  final String alias;
  final int valorHora;
  const Ajuste({
    required this.id,
    required this.nombre,
    required this.alias,
    required this.valorHora,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['alias'] = Variable<String>(alias);
    map['valor_hora'] = Variable<int>(valorHora);
    return map;
  }

  AjustesCompanion toCompanion(bool nullToAbsent) {
    return AjustesCompanion(
      id: Value(id),
      nombre: Value(nombre),
      alias: Value(alias),
      valorHora: Value(valorHora),
    );
  }

  factory Ajuste.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ajuste(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      alias: serializer.fromJson<String>(json['alias']),
      valorHora: serializer.fromJson<int>(json['valorHora']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'alias': serializer.toJson<String>(alias),
      'valorHora': serializer.toJson<int>(valorHora),
    };
  }

  Ajuste copyWith({int? id, String? nombre, String? alias, int? valorHora}) =>
      Ajuste(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        alias: alias ?? this.alias,
        valorHora: valorHora ?? this.valorHora,
      );
  Ajuste copyWithCompanion(AjustesCompanion data) {
    return Ajuste(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      alias: data.alias.present ? data.alias.value : this.alias,
      valorHora: data.valorHora.present ? data.valorHora.value : this.valorHora,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ajuste(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('alias: $alias, ')
          ..write('valorHora: $valorHora')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, alias, valorHora);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ajuste &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.alias == this.alias &&
          other.valorHora == this.valorHora);
}

class AjustesCompanion extends UpdateCompanion<Ajuste> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> alias;
  final Value<int> valorHora;
  const AjustesCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.alias = const Value.absent(),
    this.valorHora = const Value.absent(),
  });
  AjustesCompanion.insert({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.alias = const Value.absent(),
    this.valorHora = const Value.absent(),
  });
  static Insertable<Ajuste> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? alias,
    Expression<int>? valorHora,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (alias != null) 'alias': alias,
      if (valorHora != null) 'valor_hora': valorHora,
    });
  }

  AjustesCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? alias,
    Value<int>? valorHora,
  }) {
    return AjustesCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      alias: alias ?? this.alias,
      valorHora: valorHora ?? this.valorHora,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (alias.present) {
      map['alias'] = Variable<String>(alias.value);
    }
    if (valorHora.present) {
      map['valor_hora'] = Variable<int>(valorHora.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AjustesCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('alias: $alias, ')
          ..write('valorHora: $valorHora')
          ..write(')'))
        .toString();
  }
}

class $InsumosTable extends Insumos with TableInfo<$InsumosTable, Insumo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InsumosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unidadMeta = const VerificationMeta('unidad');
  @override
  late final GeneratedColumn<String> unidad = GeneratedColumn<String>(
    'unidad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contenidoMeta = const VerificationMeta(
    'contenido',
  );
  @override
  late final GeneratedColumn<int> contenido = GeneratedColumn<int>(
    'contenido',
    aliasedName,
    false,
    check: () => ComparableExpr(contenido).isBiggerThanValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costoEnvaseMeta = const VerificationMeta(
    'costoEnvase',
  );
  @override
  late final GeneratedColumn<int> costoEnvase = GeneratedColumn<int>(
    'costo_envase',
    aliasedName,
    false,
    check: () => ComparableExpr(costoEnvase).isBiggerOrEqualValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stockMeta = const VerificationMeta('stock');
  @override
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
    'stock',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _minimoMeta = const VerificationMeta('minimo');
  @override
  late final GeneratedColumn<int> minimo = GeneratedColumn<int>(
    'minimo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    unidad,
    contenido,
    costoEnvase,
    stock,
    minimo,
    activo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'insumos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Insumo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('unidad')) {
      context.handle(
        _unidadMeta,
        unidad.isAcceptableOrUnknown(data['unidad']!, _unidadMeta),
      );
    } else if (isInserting) {
      context.missing(_unidadMeta);
    }
    if (data.containsKey('contenido')) {
      context.handle(
        _contenidoMeta,
        contenido.isAcceptableOrUnknown(data['contenido']!, _contenidoMeta),
      );
    } else if (isInserting) {
      context.missing(_contenidoMeta);
    }
    if (data.containsKey('costo_envase')) {
      context.handle(
        _costoEnvaseMeta,
        costoEnvase.isAcceptableOrUnknown(
          data['costo_envase']!,
          _costoEnvaseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_costoEnvaseMeta);
    }
    if (data.containsKey('stock')) {
      context.handle(
        _stockMeta,
        stock.isAcceptableOrUnknown(data['stock']!, _stockMeta),
      );
    }
    if (data.containsKey('minimo')) {
      context.handle(
        _minimoMeta,
        minimo.isAcceptableOrUnknown(data['minimo']!, _minimoMeta),
      );
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Insumo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Insumo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      unidad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unidad'],
      )!,
      contenido: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}contenido'],
      )!,
      costoEnvase: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}costo_envase'],
      )!,
      stock: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock'],
      )!,
      minimo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minimo'],
      )!,
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activo'],
      )!,
    );
  }

  @override
  $InsumosTable createAlias(String alias) {
    return $InsumosTable(attachedDatabase, alias);
  }
}

class Insumo extends DataClass implements Insertable<Insumo> {
  final int id;
  final String nombre;
  final String unidad;
  final int contenido;
  final int costoEnvase;
  final int stock;
  final int minimo;
  final bool activo;
  const Insumo({
    required this.id,
    required this.nombre,
    required this.unidad,
    required this.contenido,
    required this.costoEnvase,
    required this.stock,
    required this.minimo,
    required this.activo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['unidad'] = Variable<String>(unidad);
    map['contenido'] = Variable<int>(contenido);
    map['costo_envase'] = Variable<int>(costoEnvase);
    map['stock'] = Variable<int>(stock);
    map['minimo'] = Variable<int>(minimo);
    map['activo'] = Variable<bool>(activo);
    return map;
  }

  InsumosCompanion toCompanion(bool nullToAbsent) {
    return InsumosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      unidad: Value(unidad),
      contenido: Value(contenido),
      costoEnvase: Value(costoEnvase),
      stock: Value(stock),
      minimo: Value(minimo),
      activo: Value(activo),
    );
  }

  factory Insumo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Insumo(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      unidad: serializer.fromJson<String>(json['unidad']),
      contenido: serializer.fromJson<int>(json['contenido']),
      costoEnvase: serializer.fromJson<int>(json['costoEnvase']),
      stock: serializer.fromJson<int>(json['stock']),
      minimo: serializer.fromJson<int>(json['minimo']),
      activo: serializer.fromJson<bool>(json['activo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'unidad': serializer.toJson<String>(unidad),
      'contenido': serializer.toJson<int>(contenido),
      'costoEnvase': serializer.toJson<int>(costoEnvase),
      'stock': serializer.toJson<int>(stock),
      'minimo': serializer.toJson<int>(minimo),
      'activo': serializer.toJson<bool>(activo),
    };
  }

  Insumo copyWith({
    int? id,
    String? nombre,
    String? unidad,
    int? contenido,
    int? costoEnvase,
    int? stock,
    int? minimo,
    bool? activo,
  }) => Insumo(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    unidad: unidad ?? this.unidad,
    contenido: contenido ?? this.contenido,
    costoEnvase: costoEnvase ?? this.costoEnvase,
    stock: stock ?? this.stock,
    minimo: minimo ?? this.minimo,
    activo: activo ?? this.activo,
  );
  Insumo copyWithCompanion(InsumosCompanion data) {
    return Insumo(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      unidad: data.unidad.present ? data.unidad.value : this.unidad,
      contenido: data.contenido.present ? data.contenido.value : this.contenido,
      costoEnvase: data.costoEnvase.present
          ? data.costoEnvase.value
          : this.costoEnvase,
      stock: data.stock.present ? data.stock.value : this.stock,
      minimo: data.minimo.present ? data.minimo.value : this.minimo,
      activo: data.activo.present ? data.activo.value : this.activo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Insumo(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('unidad: $unidad, ')
          ..write('contenido: $contenido, ')
          ..write('costoEnvase: $costoEnvase, ')
          ..write('stock: $stock, ')
          ..write('minimo: $minimo, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nombre,
    unidad,
    contenido,
    costoEnvase,
    stock,
    minimo,
    activo,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Insumo &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.unidad == this.unidad &&
          other.contenido == this.contenido &&
          other.costoEnvase == this.costoEnvase &&
          other.stock == this.stock &&
          other.minimo == this.minimo &&
          other.activo == this.activo);
}

class InsumosCompanion extends UpdateCompanion<Insumo> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> unidad;
  final Value<int> contenido;
  final Value<int> costoEnvase;
  final Value<int> stock;
  final Value<int> minimo;
  final Value<bool> activo;
  const InsumosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.unidad = const Value.absent(),
    this.contenido = const Value.absent(),
    this.costoEnvase = const Value.absent(),
    this.stock = const Value.absent(),
    this.minimo = const Value.absent(),
    this.activo = const Value.absent(),
  });
  InsumosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String unidad,
    required int contenido,
    required int costoEnvase,
    this.stock = const Value.absent(),
    this.minimo = const Value.absent(),
    this.activo = const Value.absent(),
  }) : nombre = Value(nombre),
       unidad = Value(unidad),
       contenido = Value(contenido),
       costoEnvase = Value(costoEnvase);
  static Insertable<Insumo> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? unidad,
    Expression<int>? contenido,
    Expression<int>? costoEnvase,
    Expression<int>? stock,
    Expression<int>? minimo,
    Expression<bool>? activo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (unidad != null) 'unidad': unidad,
      if (contenido != null) 'contenido': contenido,
      if (costoEnvase != null) 'costo_envase': costoEnvase,
      if (stock != null) 'stock': stock,
      if (minimo != null) 'minimo': minimo,
      if (activo != null) 'activo': activo,
    });
  }

  InsumosCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? unidad,
    Value<int>? contenido,
    Value<int>? costoEnvase,
    Value<int>? stock,
    Value<int>? minimo,
    Value<bool>? activo,
  }) {
    return InsumosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      unidad: unidad ?? this.unidad,
      contenido: contenido ?? this.contenido,
      costoEnvase: costoEnvase ?? this.costoEnvase,
      stock: stock ?? this.stock,
      minimo: minimo ?? this.minimo,
      activo: activo ?? this.activo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (unidad.present) {
      map['unidad'] = Variable<String>(unidad.value);
    }
    if (contenido.present) {
      map['contenido'] = Variable<int>(contenido.value);
    }
    if (costoEnvase.present) {
      map['costo_envase'] = Variable<int>(costoEnvase.value);
    }
    if (stock.present) {
      map['stock'] = Variable<int>(stock.value);
    }
    if (minimo.present) {
      map['minimo'] = Variable<int>(minimo.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InsumosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('unidad: $unidad, ')
          ..write('contenido: $contenido, ')
          ..write('costoEnvase: $costoEnvase, ')
          ..write('stock: $stock, ')
          ..write('minimo: $minimo, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
  }
}

class $ServiciosTable extends Servicios
    with TableInfo<$ServiciosTable, Servicio> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServiciosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _duracionMeta = const VerificationMeta(
    'duracion',
  );
  @override
  late final GeneratedColumn<int> duracion = GeneratedColumn<int>(
    'duracion',
    aliasedName,
    false,
    check: () => ComparableExpr(duracion).isBiggerThanValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _manoDeObraMeta = const VerificationMeta(
    'manoDeObra',
  );
  @override
  late final GeneratedColumn<bool> manoDeObra = GeneratedColumn<bool>(
    'mano_de_obra',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("mano_de_obra" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _gananciaBuscadaMeta = const VerificationMeta(
    'gananciaBuscada',
  );
  @override
  late final GeneratedColumn<int> gananciaBuscada = GeneratedColumn<int>(
    'ganancia_buscada',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(6000),
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    duracion,
    manoDeObra,
    gananciaBuscada,
    activo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'servicios';
  @override
  VerificationContext validateIntegrity(
    Insertable<Servicio> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('duracion')) {
      context.handle(
        _duracionMeta,
        duracion.isAcceptableOrUnknown(data['duracion']!, _duracionMeta),
      );
    } else if (isInserting) {
      context.missing(_duracionMeta);
    }
    if (data.containsKey('mano_de_obra')) {
      context.handle(
        _manoDeObraMeta,
        manoDeObra.isAcceptableOrUnknown(
          data['mano_de_obra']!,
          _manoDeObraMeta,
        ),
      );
    }
    if (data.containsKey('ganancia_buscada')) {
      context.handle(
        _gananciaBuscadaMeta,
        gananciaBuscada.isAcceptableOrUnknown(
          data['ganancia_buscada']!,
          _gananciaBuscadaMeta,
        ),
      );
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Servicio map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Servicio(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      duracion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duracion'],
      )!,
      manoDeObra: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}mano_de_obra'],
      )!,
      gananciaBuscada: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ganancia_buscada'],
      )!,
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activo'],
      )!,
    );
  }

  @override
  $ServiciosTable createAlias(String alias) {
    return $ServiciosTable(attachedDatabase, alias);
  }
}

class Servicio extends DataClass implements Insertable<Servicio> {
  final int id;
  final String nombre;
  final int duracion;
  final bool manoDeObra;
  final int gananciaBuscada;
  final bool activo;
  const Servicio({
    required this.id,
    required this.nombre,
    required this.duracion,
    required this.manoDeObra,
    required this.gananciaBuscada,
    required this.activo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['duracion'] = Variable<int>(duracion);
    map['mano_de_obra'] = Variable<bool>(manoDeObra);
    map['ganancia_buscada'] = Variable<int>(gananciaBuscada);
    map['activo'] = Variable<bool>(activo);
    return map;
  }

  ServiciosCompanion toCompanion(bool nullToAbsent) {
    return ServiciosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      duracion: Value(duracion),
      manoDeObra: Value(manoDeObra),
      gananciaBuscada: Value(gananciaBuscada),
      activo: Value(activo),
    );
  }

  factory Servicio.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Servicio(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      duracion: serializer.fromJson<int>(json['duracion']),
      manoDeObra: serializer.fromJson<bool>(json['manoDeObra']),
      gananciaBuscada: serializer.fromJson<int>(json['gananciaBuscada']),
      activo: serializer.fromJson<bool>(json['activo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'duracion': serializer.toJson<int>(duracion),
      'manoDeObra': serializer.toJson<bool>(manoDeObra),
      'gananciaBuscada': serializer.toJson<int>(gananciaBuscada),
      'activo': serializer.toJson<bool>(activo),
    };
  }

  Servicio copyWith({
    int? id,
    String? nombre,
    int? duracion,
    bool? manoDeObra,
    int? gananciaBuscada,
    bool? activo,
  }) => Servicio(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    duracion: duracion ?? this.duracion,
    manoDeObra: manoDeObra ?? this.manoDeObra,
    gananciaBuscada: gananciaBuscada ?? this.gananciaBuscada,
    activo: activo ?? this.activo,
  );
  Servicio copyWithCompanion(ServiciosCompanion data) {
    return Servicio(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      duracion: data.duracion.present ? data.duracion.value : this.duracion,
      manoDeObra: data.manoDeObra.present
          ? data.manoDeObra.value
          : this.manoDeObra,
      gananciaBuscada: data.gananciaBuscada.present
          ? data.gananciaBuscada.value
          : this.gananciaBuscada,
      activo: data.activo.present ? data.activo.value : this.activo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Servicio(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('duracion: $duracion, ')
          ..write('manoDeObra: $manoDeObra, ')
          ..write('gananciaBuscada: $gananciaBuscada, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, duracion, manoDeObra, gananciaBuscada, activo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Servicio &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.duracion == this.duracion &&
          other.manoDeObra == this.manoDeObra &&
          other.gananciaBuscada == this.gananciaBuscada &&
          other.activo == this.activo);
}

class ServiciosCompanion extends UpdateCompanion<Servicio> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<int> duracion;
  final Value<bool> manoDeObra;
  final Value<int> gananciaBuscada;
  final Value<bool> activo;
  const ServiciosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.duracion = const Value.absent(),
    this.manoDeObra = const Value.absent(),
    this.gananciaBuscada = const Value.absent(),
    this.activo = const Value.absent(),
  });
  ServiciosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required int duracion,
    this.manoDeObra = const Value.absent(),
    this.gananciaBuscada = const Value.absent(),
    this.activo = const Value.absent(),
  }) : nombre = Value(nombre),
       duracion = Value(duracion);
  static Insertable<Servicio> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<int>? duracion,
    Expression<bool>? manoDeObra,
    Expression<int>? gananciaBuscada,
    Expression<bool>? activo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (duracion != null) 'duracion': duracion,
      if (manoDeObra != null) 'mano_de_obra': manoDeObra,
      if (gananciaBuscada != null) 'ganancia_buscada': gananciaBuscada,
      if (activo != null) 'activo': activo,
    });
  }

  ServiciosCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<int>? duracion,
    Value<bool>? manoDeObra,
    Value<int>? gananciaBuscada,
    Value<bool>? activo,
  }) {
    return ServiciosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      duracion: duracion ?? this.duracion,
      manoDeObra: manoDeObra ?? this.manoDeObra,
      gananciaBuscada: gananciaBuscada ?? this.gananciaBuscada,
      activo: activo ?? this.activo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (duracion.present) {
      map['duracion'] = Variable<int>(duracion.value);
    }
    if (manoDeObra.present) {
      map['mano_de_obra'] = Variable<bool>(manoDeObra.value);
    }
    if (gananciaBuscada.present) {
      map['ganancia_buscada'] = Variable<int>(gananciaBuscada.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiciosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('duracion: $duracion, ')
          ..write('manoDeObra: $manoDeObra, ')
          ..write('gananciaBuscada: $gananciaBuscada, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
  }
}

class $TarifasTable extends Tarifas with TableInfo<$TarifasTable, Tarifa> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TarifasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _servicioIdMeta = const VerificationMeta(
    'servicioId',
  );
  @override
  late final GeneratedColumn<int> servicioId = GeneratedColumn<int>(
    'servicio_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES servicios (id)',
    ),
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioMeta = const VerificationMeta('precio');
  @override
  late final GeneratedColumn<int> precio = GeneratedColumn<int>(
    'precio',
    aliasedName,
    false,
    check: () => ComparableExpr(precio).isBiggerThanValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [servicioId, tipo, precio];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tarifas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tarifa> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('servicio_id')) {
      context.handle(
        _servicioIdMeta,
        servicioId.isAcceptableOrUnknown(data['servicio_id']!, _servicioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_servicioIdMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('precio')) {
      context.handle(
        _precioMeta,
        precio.isAcceptableOrUnknown(data['precio']!, _precioMeta),
      );
    } else if (isInserting) {
      context.missing(_precioMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {servicioId, tipo};
  @override
  Tarifa map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tarifa(
      servicioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}servicio_id'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      precio: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}precio'],
      )!,
    );
  }

  @override
  $TarifasTable createAlias(String alias) {
    return $TarifasTable(attachedDatabase, alias);
  }
}

class Tarifa extends DataClass implements Insertable<Tarifa> {
  final int servicioId;
  final String tipo;
  final int precio;
  const Tarifa({
    required this.servicioId,
    required this.tipo,
    required this.precio,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['servicio_id'] = Variable<int>(servicioId);
    map['tipo'] = Variable<String>(tipo);
    map['precio'] = Variable<int>(precio);
    return map;
  }

  TarifasCompanion toCompanion(bool nullToAbsent) {
    return TarifasCompanion(
      servicioId: Value(servicioId),
      tipo: Value(tipo),
      precio: Value(precio),
    );
  }

  factory Tarifa.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tarifa(
      servicioId: serializer.fromJson<int>(json['servicioId']),
      tipo: serializer.fromJson<String>(json['tipo']),
      precio: serializer.fromJson<int>(json['precio']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'servicioId': serializer.toJson<int>(servicioId),
      'tipo': serializer.toJson<String>(tipo),
      'precio': serializer.toJson<int>(precio),
    };
  }

  Tarifa copyWith({int? servicioId, String? tipo, int? precio}) => Tarifa(
    servicioId: servicioId ?? this.servicioId,
    tipo: tipo ?? this.tipo,
    precio: precio ?? this.precio,
  );
  Tarifa copyWithCompanion(TarifasCompanion data) {
    return Tarifa(
      servicioId: data.servicioId.present
          ? data.servicioId.value
          : this.servicioId,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      precio: data.precio.present ? data.precio.value : this.precio,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tarifa(')
          ..write('servicioId: $servicioId, ')
          ..write('tipo: $tipo, ')
          ..write('precio: $precio')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(servicioId, tipo, precio);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tarifa &&
          other.servicioId == this.servicioId &&
          other.tipo == this.tipo &&
          other.precio == this.precio);
}

class TarifasCompanion extends UpdateCompanion<Tarifa> {
  final Value<int> servicioId;
  final Value<String> tipo;
  final Value<int> precio;
  final Value<int> rowid;
  const TarifasCompanion({
    this.servicioId = const Value.absent(),
    this.tipo = const Value.absent(),
    this.precio = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TarifasCompanion.insert({
    required int servicioId,
    required String tipo,
    required int precio,
    this.rowid = const Value.absent(),
  }) : servicioId = Value(servicioId),
       tipo = Value(tipo),
       precio = Value(precio);
  static Insertable<Tarifa> custom({
    Expression<int>? servicioId,
    Expression<String>? tipo,
    Expression<int>? precio,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (servicioId != null) 'servicio_id': servicioId,
      if (tipo != null) 'tipo': tipo,
      if (precio != null) 'precio': precio,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TarifasCompanion copyWith({
    Value<int>? servicioId,
    Value<String>? tipo,
    Value<int>? precio,
    Value<int>? rowid,
  }) {
    return TarifasCompanion(
      servicioId: servicioId ?? this.servicioId,
      tipo: tipo ?? this.tipo,
      precio: precio ?? this.precio,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (servicioId.present) {
      map['servicio_id'] = Variable<int>(servicioId.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (precio.present) {
      map['precio'] = Variable<int>(precio.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TarifasCompanion(')
          ..write('servicioId: $servicioId, ')
          ..write('tipo: $tipo, ')
          ..write('precio: $precio, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecetasTable extends Recetas with TableInfo<$RecetasTable, Receta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecetasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _servicioIdMeta = const VerificationMeta(
    'servicioId',
  );
  @override
  late final GeneratedColumn<int> servicioId = GeneratedColumn<int>(
    'servicio_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES servicios (id)',
    ),
  );
  static const VerificationMeta _insumoIdMeta = const VerificationMeta(
    'insumoId',
  );
  @override
  late final GeneratedColumn<int> insumoId = GeneratedColumn<int>(
    'insumo_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES insumos (id)',
    ),
  );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<int> cantidad = GeneratedColumn<int>(
    'cantidad',
    aliasedName,
    false,
    check: () => ComparableExpr(cantidad).isBiggerThanValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [servicioId, insumoId, cantidad];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recetas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Receta> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('servicio_id')) {
      context.handle(
        _servicioIdMeta,
        servicioId.isAcceptableOrUnknown(data['servicio_id']!, _servicioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_servicioIdMeta);
    }
    if (data.containsKey('insumo_id')) {
      context.handle(
        _insumoIdMeta,
        insumoId.isAcceptableOrUnknown(data['insumo_id']!, _insumoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_insumoIdMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {servicioId, insumoId};
  @override
  Receta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Receta(
      servicioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}servicio_id'],
      )!,
      insumoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}insumo_id'],
      )!,
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cantidad'],
      )!,
    );
  }

  @override
  $RecetasTable createAlias(String alias) {
    return $RecetasTable(attachedDatabase, alias);
  }
}

class Receta extends DataClass implements Insertable<Receta> {
  final int servicioId;
  final int insumoId;
  final int cantidad;
  const Receta({
    required this.servicioId,
    required this.insumoId,
    required this.cantidad,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['servicio_id'] = Variable<int>(servicioId);
    map['insumo_id'] = Variable<int>(insumoId);
    map['cantidad'] = Variable<int>(cantidad);
    return map;
  }

  RecetasCompanion toCompanion(bool nullToAbsent) {
    return RecetasCompanion(
      servicioId: Value(servicioId),
      insumoId: Value(insumoId),
      cantidad: Value(cantidad),
    );
  }

  factory Receta.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Receta(
      servicioId: serializer.fromJson<int>(json['servicioId']),
      insumoId: serializer.fromJson<int>(json['insumoId']),
      cantidad: serializer.fromJson<int>(json['cantidad']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'servicioId': serializer.toJson<int>(servicioId),
      'insumoId': serializer.toJson<int>(insumoId),
      'cantidad': serializer.toJson<int>(cantidad),
    };
  }

  Receta copyWith({int? servicioId, int? insumoId, int? cantidad}) => Receta(
    servicioId: servicioId ?? this.servicioId,
    insumoId: insumoId ?? this.insumoId,
    cantidad: cantidad ?? this.cantidad,
  );
  Receta copyWithCompanion(RecetasCompanion data) {
    return Receta(
      servicioId: data.servicioId.present
          ? data.servicioId.value
          : this.servicioId,
      insumoId: data.insumoId.present ? data.insumoId.value : this.insumoId,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Receta(')
          ..write('servicioId: $servicioId, ')
          ..write('insumoId: $insumoId, ')
          ..write('cantidad: $cantidad')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(servicioId, insumoId, cantidad);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Receta &&
          other.servicioId == this.servicioId &&
          other.insumoId == this.insumoId &&
          other.cantidad == this.cantidad);
}

class RecetasCompanion extends UpdateCompanion<Receta> {
  final Value<int> servicioId;
  final Value<int> insumoId;
  final Value<int> cantidad;
  final Value<int> rowid;
  const RecetasCompanion({
    this.servicioId = const Value.absent(),
    this.insumoId = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecetasCompanion.insert({
    required int servicioId,
    required int insumoId,
    required int cantidad,
    this.rowid = const Value.absent(),
  }) : servicioId = Value(servicioId),
       insumoId = Value(insumoId),
       cantidad = Value(cantidad);
  static Insertable<Receta> custom({
    Expression<int>? servicioId,
    Expression<int>? insumoId,
    Expression<int>? cantidad,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (servicioId != null) 'servicio_id': servicioId,
      if (insumoId != null) 'insumo_id': insumoId,
      if (cantidad != null) 'cantidad': cantidad,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecetasCompanion copyWith({
    Value<int>? servicioId,
    Value<int>? insumoId,
    Value<int>? cantidad,
    Value<int>? rowid,
  }) {
    return RecetasCompanion(
      servicioId: servicioId ?? this.servicioId,
      insumoId: insumoId ?? this.insumoId,
      cantidad: cantidad ?? this.cantidad,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (servicioId.present) {
      map['servicio_id'] = Variable<int>(servicioId.value);
    }
    if (insumoId.present) {
      map['insumo_id'] = Variable<int>(insumoId.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<int>(cantidad.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecetasCompanion(')
          ..write('servicioId: $servicioId, ')
          ..write('insumoId: $insumoId, ')
          ..write('cantidad: $cantidad, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VehiculosTable extends Vehiculos
    with TableInfo<$VehiculosTable, Vehiculo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiculosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _patenteMeta = const VerificationMeta(
    'patente',
  );
  @override
  late final GeneratedColumn<String> patente = GeneratedColumn<String>(
    'patente',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _modeloMeta = const VerificationMeta('modelo');
  @override
  late final GeneratedColumn<String> modelo = GeneratedColumn<String>(
    'modelo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clienteMeta = const VerificationMeta(
    'cliente',
  );
  @override
  late final GeneratedColumn<String> cliente = GeneratedColumn<String>(
    'cliente',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _telefonoMeta = const VerificationMeta(
    'telefono',
  );
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
    'telefono',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _notasMeta = const VerificationMeta('notas');
  @override
  late final GeneratedColumn<String> notas = GeneratedColumn<String>(
    'notas',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patente,
    modelo,
    tipo,
    cliente,
    telefono,
    notas,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehiculos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Vehiculo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('patente')) {
      context.handle(
        _patenteMeta,
        patente.isAcceptableOrUnknown(data['patente']!, _patenteMeta),
      );
    } else if (isInserting) {
      context.missing(_patenteMeta);
    }
    if (data.containsKey('modelo')) {
      context.handle(
        _modeloMeta,
        modelo.isAcceptableOrUnknown(data['modelo']!, _modeloMeta),
      );
    } else if (isInserting) {
      context.missing(_modeloMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('cliente')) {
      context.handle(
        _clienteMeta,
        cliente.isAcceptableOrUnknown(data['cliente']!, _clienteMeta),
      );
    }
    if (data.containsKey('telefono')) {
      context.handle(
        _telefonoMeta,
        telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta),
      );
    }
    if (data.containsKey('notas')) {
      context.handle(
        _notasMeta,
        notas.isAcceptableOrUnknown(data['notas']!, _notasMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vehiculo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vehiculo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      patente: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patente'],
      )!,
      modelo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}modelo'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      cliente: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cliente'],
      )!,
      telefono: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telefono'],
      )!,
      notas: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notas'],
      )!,
    );
  }

  @override
  $VehiculosTable createAlias(String alias) {
    return $VehiculosTable(attachedDatabase, alias);
  }
}

class Vehiculo extends DataClass implements Insertable<Vehiculo> {
  final int id;
  final String patente;
  final String modelo;
  final String tipo;
  final String cliente;
  final String telefono;
  final String notas;
  const Vehiculo({
    required this.id,
    required this.patente,
    required this.modelo,
    required this.tipo,
    required this.cliente,
    required this.telefono,
    required this.notas,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['patente'] = Variable<String>(patente);
    map['modelo'] = Variable<String>(modelo);
    map['tipo'] = Variable<String>(tipo);
    map['cliente'] = Variable<String>(cliente);
    map['telefono'] = Variable<String>(telefono);
    map['notas'] = Variable<String>(notas);
    return map;
  }

  VehiculosCompanion toCompanion(bool nullToAbsent) {
    return VehiculosCompanion(
      id: Value(id),
      patente: Value(patente),
      modelo: Value(modelo),
      tipo: Value(tipo),
      cliente: Value(cliente),
      telefono: Value(telefono),
      notas: Value(notas),
    );
  }

  factory Vehiculo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vehiculo(
      id: serializer.fromJson<int>(json['id']),
      patente: serializer.fromJson<String>(json['patente']),
      modelo: serializer.fromJson<String>(json['modelo']),
      tipo: serializer.fromJson<String>(json['tipo']),
      cliente: serializer.fromJson<String>(json['cliente']),
      telefono: serializer.fromJson<String>(json['telefono']),
      notas: serializer.fromJson<String>(json['notas']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'patente': serializer.toJson<String>(patente),
      'modelo': serializer.toJson<String>(modelo),
      'tipo': serializer.toJson<String>(tipo),
      'cliente': serializer.toJson<String>(cliente),
      'telefono': serializer.toJson<String>(telefono),
      'notas': serializer.toJson<String>(notas),
    };
  }

  Vehiculo copyWith({
    int? id,
    String? patente,
    String? modelo,
    String? tipo,
    String? cliente,
    String? telefono,
    String? notas,
  }) => Vehiculo(
    id: id ?? this.id,
    patente: patente ?? this.patente,
    modelo: modelo ?? this.modelo,
    tipo: tipo ?? this.tipo,
    cliente: cliente ?? this.cliente,
    telefono: telefono ?? this.telefono,
    notas: notas ?? this.notas,
  );
  Vehiculo copyWithCompanion(VehiculosCompanion data) {
    return Vehiculo(
      id: data.id.present ? data.id.value : this.id,
      patente: data.patente.present ? data.patente.value : this.patente,
      modelo: data.modelo.present ? data.modelo.value : this.modelo,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      cliente: data.cliente.present ? data.cliente.value : this.cliente,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      notas: data.notas.present ? data.notas.value : this.notas,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vehiculo(')
          ..write('id: $id, ')
          ..write('patente: $patente, ')
          ..write('modelo: $modelo, ')
          ..write('tipo: $tipo, ')
          ..write('cliente: $cliente, ')
          ..write('telefono: $telefono, ')
          ..write('notas: $notas')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, patente, modelo, tipo, cliente, telefono, notas);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vehiculo &&
          other.id == this.id &&
          other.patente == this.patente &&
          other.modelo == this.modelo &&
          other.tipo == this.tipo &&
          other.cliente == this.cliente &&
          other.telefono == this.telefono &&
          other.notas == this.notas);
}

class VehiculosCompanion extends UpdateCompanion<Vehiculo> {
  final Value<int> id;
  final Value<String> patente;
  final Value<String> modelo;
  final Value<String> tipo;
  final Value<String> cliente;
  final Value<String> telefono;
  final Value<String> notas;
  const VehiculosCompanion({
    this.id = const Value.absent(),
    this.patente = const Value.absent(),
    this.modelo = const Value.absent(),
    this.tipo = const Value.absent(),
    this.cliente = const Value.absent(),
    this.telefono = const Value.absent(),
    this.notas = const Value.absent(),
  });
  VehiculosCompanion.insert({
    this.id = const Value.absent(),
    required String patente,
    required String modelo,
    required String tipo,
    this.cliente = const Value.absent(),
    this.telefono = const Value.absent(),
    this.notas = const Value.absent(),
  }) : patente = Value(patente),
       modelo = Value(modelo),
       tipo = Value(tipo);
  static Insertable<Vehiculo> custom({
    Expression<int>? id,
    Expression<String>? patente,
    Expression<String>? modelo,
    Expression<String>? tipo,
    Expression<String>? cliente,
    Expression<String>? telefono,
    Expression<String>? notas,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patente != null) 'patente': patente,
      if (modelo != null) 'modelo': modelo,
      if (tipo != null) 'tipo': tipo,
      if (cliente != null) 'cliente': cliente,
      if (telefono != null) 'telefono': telefono,
      if (notas != null) 'notas': notas,
    });
  }

  VehiculosCompanion copyWith({
    Value<int>? id,
    Value<String>? patente,
    Value<String>? modelo,
    Value<String>? tipo,
    Value<String>? cliente,
    Value<String>? telefono,
    Value<String>? notas,
  }) {
    return VehiculosCompanion(
      id: id ?? this.id,
      patente: patente ?? this.patente,
      modelo: modelo ?? this.modelo,
      tipo: tipo ?? this.tipo,
      cliente: cliente ?? this.cliente,
      telefono: telefono ?? this.telefono,
      notas: notas ?? this.notas,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (patente.present) {
      map['patente'] = Variable<String>(patente.value);
    }
    if (modelo.present) {
      map['modelo'] = Variable<String>(modelo.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (cliente.present) {
      map['cliente'] = Variable<String>(cliente.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (notas.present) {
      map['notas'] = Variable<String>(notas.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiculosCompanion(')
          ..write('id: $id, ')
          ..write('patente: $patente, ')
          ..write('modelo: $modelo, ')
          ..write('tipo: $tipo, ')
          ..write('cliente: $cliente, ')
          ..write('telefono: $telefono, ')
          ..write('notas: $notas')
          ..write(')'))
        .toString();
  }
}

class $OrdenesTable extends Ordenes with TableInfo<$OrdenesTable, OrdenLavado> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdenesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vehiculoIdMeta = const VerificationMeta(
    'vehiculoId',
  );
  @override
  late final GeneratedColumn<int> vehiculoId = GeneratedColumn<int>(
    'vehiculo_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehiculos (id)',
    ),
  );
  static const VerificationMeta _patenteMeta = const VerificationMeta(
    'patente',
  );
  @override
  late final GeneratedColumn<String> patente = GeneratedColumn<String>(
    'patente',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeloMeta = const VerificationMeta('modelo');
  @override
  late final GeneratedColumn<String> modelo = GeneratedColumn<String>(
    'modelo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clienteMeta = const VerificationMeta(
    'cliente',
  );
  @override
  late final GeneratedColumn<String> cliente = GeneratedColumn<String>(
    'cliente',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _telefonoMeta = const VerificationMeta(
    'telefono',
  );
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
    'telefono',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _responsableMeta = const VerificationMeta(
    'responsable',
  );
  @override
  late final GeneratedColumn<String> responsable = GeneratedColumn<String>(
    'responsable',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _notasMeta = const VerificationMeta('notas');
  @override
  late final GeneratedColumn<String> notas = GeneratedColumn<String>(
    'notas',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('recibido'),
  );
  static const VerificationMeta _creadaMeta = const VerificationMeta('creada');
  @override
  late final GeneratedColumn<DateTime> creada = GeneratedColumn<DateTime>(
    'creada',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _programadaMeta = const VerificationMeta(
    'programada',
  );
  @override
  late final GeneratedColumn<DateTime> programada = GeneratedColumn<DateTime>(
    'programada',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iniciadaMeta = const VerificationMeta(
    'iniciada',
  );
  @override
  late final GeneratedColumn<DateTime> iniciada = GeneratedColumn<DateTime>(
    'iniciada',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _terminadaMeta = const VerificationMeta(
    'terminada',
  );
  @override
  late final GeneratedColumn<DateTime> terminada = GeneratedColumn<DateTime>(
    'terminada',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entregadaMeta = const VerificationMeta(
    'entregada',
  );
  @override
  late final GeneratedColumn<DateTime> entregada = GeneratedColumn<DateTime>(
    'entregada',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _operacionMeta = const VerificationMeta(
    'operacion',
  );
  @override
  late final GeneratedColumn<String> operacion = GeneratedColumn<String>(
    'operacion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehiculoId,
    patente,
    modelo,
    tipo,
    cliente,
    telefono,
    responsable,
    notas,
    estado,
    creada,
    programada,
    iniciada,
    terminada,
    entregada,
    operacion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ordenes';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrdenLavado> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehiculo_id')) {
      context.handle(
        _vehiculoIdMeta,
        vehiculoId.isAcceptableOrUnknown(data['vehiculo_id']!, _vehiculoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehiculoIdMeta);
    }
    if (data.containsKey('patente')) {
      context.handle(
        _patenteMeta,
        patente.isAcceptableOrUnknown(data['patente']!, _patenteMeta),
      );
    } else if (isInserting) {
      context.missing(_patenteMeta);
    }
    if (data.containsKey('modelo')) {
      context.handle(
        _modeloMeta,
        modelo.isAcceptableOrUnknown(data['modelo']!, _modeloMeta),
      );
    } else if (isInserting) {
      context.missing(_modeloMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('cliente')) {
      context.handle(
        _clienteMeta,
        cliente.isAcceptableOrUnknown(data['cliente']!, _clienteMeta),
      );
    } else if (isInserting) {
      context.missing(_clienteMeta);
    }
    if (data.containsKey('telefono')) {
      context.handle(
        _telefonoMeta,
        telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta),
      );
    } else if (isInserting) {
      context.missing(_telefonoMeta);
    }
    if (data.containsKey('responsable')) {
      context.handle(
        _responsableMeta,
        responsable.isAcceptableOrUnknown(
          data['responsable']!,
          _responsableMeta,
        ),
      );
    }
    if (data.containsKey('notas')) {
      context.handle(
        _notasMeta,
        notas.isAcceptableOrUnknown(data['notas']!, _notasMeta),
      );
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    if (data.containsKey('creada')) {
      context.handle(
        _creadaMeta,
        creada.isAcceptableOrUnknown(data['creada']!, _creadaMeta),
      );
    }
    if (data.containsKey('programada')) {
      context.handle(
        _programadaMeta,
        programada.isAcceptableOrUnknown(data['programada']!, _programadaMeta),
      );
    }
    if (data.containsKey('iniciada')) {
      context.handle(
        _iniciadaMeta,
        iniciada.isAcceptableOrUnknown(data['iniciada']!, _iniciadaMeta),
      );
    }
    if (data.containsKey('terminada')) {
      context.handle(
        _terminadaMeta,
        terminada.isAcceptableOrUnknown(data['terminada']!, _terminadaMeta),
      );
    }
    if (data.containsKey('entregada')) {
      context.handle(
        _entregadaMeta,
        entregada.isAcceptableOrUnknown(data['entregada']!, _entregadaMeta),
      );
    }
    if (data.containsKey('operacion')) {
      context.handle(
        _operacionMeta,
        operacion.isAcceptableOrUnknown(data['operacion']!, _operacionMeta),
      );
    } else if (isInserting) {
      context.missing(_operacionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrdenLavado map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrdenLavado(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehiculoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehiculo_id'],
      )!,
      patente: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patente'],
      )!,
      modelo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}modelo'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      cliente: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cliente'],
      )!,
      telefono: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telefono'],
      )!,
      responsable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}responsable'],
      )!,
      notas: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notas'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
      creada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creada'],
      )!,
      programada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}programada'],
      ),
      iniciada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}iniciada'],
      ),
      terminada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}terminada'],
      ),
      entregada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}entregada'],
      ),
      operacion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operacion'],
      )!,
    );
  }

  @override
  $OrdenesTable createAlias(String alias) {
    return $OrdenesTable(attachedDatabase, alias);
  }
}

class OrdenLavado extends DataClass implements Insertable<OrdenLavado> {
  final int id;
  final int vehiculoId;
  final String patente;
  final String modelo;
  final String tipo;
  final String cliente;
  final String telefono;
  final String responsable;
  final String notas;
  final String estado;
  final DateTime creada;
  final DateTime? programada;
  final DateTime? iniciada;
  final DateTime? terminada;
  final DateTime? entregada;

  /// Cada alta tiene identidad propia: reintentar una escritura no duplica el trabajo.
  final String operacion;
  const OrdenLavado({
    required this.id,
    required this.vehiculoId,
    required this.patente,
    required this.modelo,
    required this.tipo,
    required this.cliente,
    required this.telefono,
    required this.responsable,
    required this.notas,
    required this.estado,
    required this.creada,
    this.programada,
    this.iniciada,
    this.terminada,
    this.entregada,
    required this.operacion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehiculo_id'] = Variable<int>(vehiculoId);
    map['patente'] = Variable<String>(patente);
    map['modelo'] = Variable<String>(modelo);
    map['tipo'] = Variable<String>(tipo);
    map['cliente'] = Variable<String>(cliente);
    map['telefono'] = Variable<String>(telefono);
    map['responsable'] = Variable<String>(responsable);
    map['notas'] = Variable<String>(notas);
    map['estado'] = Variable<String>(estado);
    map['creada'] = Variable<DateTime>(creada);
    if (!nullToAbsent || programada != null) {
      map['programada'] = Variable<DateTime>(programada);
    }
    if (!nullToAbsent || iniciada != null) {
      map['iniciada'] = Variable<DateTime>(iniciada);
    }
    if (!nullToAbsent || terminada != null) {
      map['terminada'] = Variable<DateTime>(terminada);
    }
    if (!nullToAbsent || entregada != null) {
      map['entregada'] = Variable<DateTime>(entregada);
    }
    map['operacion'] = Variable<String>(operacion);
    return map;
  }

  OrdenesCompanion toCompanion(bool nullToAbsent) {
    return OrdenesCompanion(
      id: Value(id),
      vehiculoId: Value(vehiculoId),
      patente: Value(patente),
      modelo: Value(modelo),
      tipo: Value(tipo),
      cliente: Value(cliente),
      telefono: Value(telefono),
      responsable: Value(responsable),
      notas: Value(notas),
      estado: Value(estado),
      creada: Value(creada),
      programada: programada == null && nullToAbsent
          ? const Value.absent()
          : Value(programada),
      iniciada: iniciada == null && nullToAbsent
          ? const Value.absent()
          : Value(iniciada),
      terminada: terminada == null && nullToAbsent
          ? const Value.absent()
          : Value(terminada),
      entregada: entregada == null && nullToAbsent
          ? const Value.absent()
          : Value(entregada),
      operacion: Value(operacion),
    );
  }

  factory OrdenLavado.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrdenLavado(
      id: serializer.fromJson<int>(json['id']),
      vehiculoId: serializer.fromJson<int>(json['vehiculoId']),
      patente: serializer.fromJson<String>(json['patente']),
      modelo: serializer.fromJson<String>(json['modelo']),
      tipo: serializer.fromJson<String>(json['tipo']),
      cliente: serializer.fromJson<String>(json['cliente']),
      telefono: serializer.fromJson<String>(json['telefono']),
      responsable: serializer.fromJson<String>(json['responsable']),
      notas: serializer.fromJson<String>(json['notas']),
      estado: serializer.fromJson<String>(json['estado']),
      creada: serializer.fromJson<DateTime>(json['creada']),
      programada: serializer.fromJson<DateTime?>(json['programada']),
      iniciada: serializer.fromJson<DateTime?>(json['iniciada']),
      terminada: serializer.fromJson<DateTime?>(json['terminada']),
      entregada: serializer.fromJson<DateTime?>(json['entregada']),
      operacion: serializer.fromJson<String>(json['operacion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehiculoId': serializer.toJson<int>(vehiculoId),
      'patente': serializer.toJson<String>(patente),
      'modelo': serializer.toJson<String>(modelo),
      'tipo': serializer.toJson<String>(tipo),
      'cliente': serializer.toJson<String>(cliente),
      'telefono': serializer.toJson<String>(telefono),
      'responsable': serializer.toJson<String>(responsable),
      'notas': serializer.toJson<String>(notas),
      'estado': serializer.toJson<String>(estado),
      'creada': serializer.toJson<DateTime>(creada),
      'programada': serializer.toJson<DateTime?>(programada),
      'iniciada': serializer.toJson<DateTime?>(iniciada),
      'terminada': serializer.toJson<DateTime?>(terminada),
      'entregada': serializer.toJson<DateTime?>(entregada),
      'operacion': serializer.toJson<String>(operacion),
    };
  }

  OrdenLavado copyWith({
    int? id,
    int? vehiculoId,
    String? patente,
    String? modelo,
    String? tipo,
    String? cliente,
    String? telefono,
    String? responsable,
    String? notas,
    String? estado,
    DateTime? creada,
    Value<DateTime?> programada = const Value.absent(),
    Value<DateTime?> iniciada = const Value.absent(),
    Value<DateTime?> terminada = const Value.absent(),
    Value<DateTime?> entregada = const Value.absent(),
    String? operacion,
  }) => OrdenLavado(
    id: id ?? this.id,
    vehiculoId: vehiculoId ?? this.vehiculoId,
    patente: patente ?? this.patente,
    modelo: modelo ?? this.modelo,
    tipo: tipo ?? this.tipo,
    cliente: cliente ?? this.cliente,
    telefono: telefono ?? this.telefono,
    responsable: responsable ?? this.responsable,
    notas: notas ?? this.notas,
    estado: estado ?? this.estado,
    creada: creada ?? this.creada,
    programada: programada.present ? programada.value : this.programada,
    iniciada: iniciada.present ? iniciada.value : this.iniciada,
    terminada: terminada.present ? terminada.value : this.terminada,
    entregada: entregada.present ? entregada.value : this.entregada,
    operacion: operacion ?? this.operacion,
  );
  OrdenLavado copyWithCompanion(OrdenesCompanion data) {
    return OrdenLavado(
      id: data.id.present ? data.id.value : this.id,
      vehiculoId: data.vehiculoId.present
          ? data.vehiculoId.value
          : this.vehiculoId,
      patente: data.patente.present ? data.patente.value : this.patente,
      modelo: data.modelo.present ? data.modelo.value : this.modelo,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      cliente: data.cliente.present ? data.cliente.value : this.cliente,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      responsable: data.responsable.present
          ? data.responsable.value
          : this.responsable,
      notas: data.notas.present ? data.notas.value : this.notas,
      estado: data.estado.present ? data.estado.value : this.estado,
      creada: data.creada.present ? data.creada.value : this.creada,
      programada: data.programada.present
          ? data.programada.value
          : this.programada,
      iniciada: data.iniciada.present ? data.iniciada.value : this.iniciada,
      terminada: data.terminada.present ? data.terminada.value : this.terminada,
      entregada: data.entregada.present ? data.entregada.value : this.entregada,
      operacion: data.operacion.present ? data.operacion.value : this.operacion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrdenLavado(')
          ..write('id: $id, ')
          ..write('vehiculoId: $vehiculoId, ')
          ..write('patente: $patente, ')
          ..write('modelo: $modelo, ')
          ..write('tipo: $tipo, ')
          ..write('cliente: $cliente, ')
          ..write('telefono: $telefono, ')
          ..write('responsable: $responsable, ')
          ..write('notas: $notas, ')
          ..write('estado: $estado, ')
          ..write('creada: $creada, ')
          ..write('programada: $programada, ')
          ..write('iniciada: $iniciada, ')
          ..write('terminada: $terminada, ')
          ..write('entregada: $entregada, ')
          ..write('operacion: $operacion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehiculoId,
    patente,
    modelo,
    tipo,
    cliente,
    telefono,
    responsable,
    notas,
    estado,
    creada,
    programada,
    iniciada,
    terminada,
    entregada,
    operacion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrdenLavado &&
          other.id == this.id &&
          other.vehiculoId == this.vehiculoId &&
          other.patente == this.patente &&
          other.modelo == this.modelo &&
          other.tipo == this.tipo &&
          other.cliente == this.cliente &&
          other.telefono == this.telefono &&
          other.responsable == this.responsable &&
          other.notas == this.notas &&
          other.estado == this.estado &&
          other.creada == this.creada &&
          other.programada == this.programada &&
          other.iniciada == this.iniciada &&
          other.terminada == this.terminada &&
          other.entregada == this.entregada &&
          other.operacion == this.operacion);
}

class OrdenesCompanion extends UpdateCompanion<OrdenLavado> {
  final Value<int> id;
  final Value<int> vehiculoId;
  final Value<String> patente;
  final Value<String> modelo;
  final Value<String> tipo;
  final Value<String> cliente;
  final Value<String> telefono;
  final Value<String> responsable;
  final Value<String> notas;
  final Value<String> estado;
  final Value<DateTime> creada;
  final Value<DateTime?> programada;
  final Value<DateTime?> iniciada;
  final Value<DateTime?> terminada;
  final Value<DateTime?> entregada;
  final Value<String> operacion;
  const OrdenesCompanion({
    this.id = const Value.absent(),
    this.vehiculoId = const Value.absent(),
    this.patente = const Value.absent(),
    this.modelo = const Value.absent(),
    this.tipo = const Value.absent(),
    this.cliente = const Value.absent(),
    this.telefono = const Value.absent(),
    this.responsable = const Value.absent(),
    this.notas = const Value.absent(),
    this.estado = const Value.absent(),
    this.creada = const Value.absent(),
    this.programada = const Value.absent(),
    this.iniciada = const Value.absent(),
    this.terminada = const Value.absent(),
    this.entregada = const Value.absent(),
    this.operacion = const Value.absent(),
  });
  OrdenesCompanion.insert({
    this.id = const Value.absent(),
    required int vehiculoId,
    required String patente,
    required String modelo,
    required String tipo,
    required String cliente,
    required String telefono,
    this.responsable = const Value.absent(),
    this.notas = const Value.absent(),
    this.estado = const Value.absent(),
    this.creada = const Value.absent(),
    this.programada = const Value.absent(),
    this.iniciada = const Value.absent(),
    this.terminada = const Value.absent(),
    this.entregada = const Value.absent(),
    required String operacion,
  }) : vehiculoId = Value(vehiculoId),
       patente = Value(patente),
       modelo = Value(modelo),
       tipo = Value(tipo),
       cliente = Value(cliente),
       telefono = Value(telefono),
       operacion = Value(operacion);
  static Insertable<OrdenLavado> custom({
    Expression<int>? id,
    Expression<int>? vehiculoId,
    Expression<String>? patente,
    Expression<String>? modelo,
    Expression<String>? tipo,
    Expression<String>? cliente,
    Expression<String>? telefono,
    Expression<String>? responsable,
    Expression<String>? notas,
    Expression<String>? estado,
    Expression<DateTime>? creada,
    Expression<DateTime>? programada,
    Expression<DateTime>? iniciada,
    Expression<DateTime>? terminada,
    Expression<DateTime>? entregada,
    Expression<String>? operacion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehiculoId != null) 'vehiculo_id': vehiculoId,
      if (patente != null) 'patente': patente,
      if (modelo != null) 'modelo': modelo,
      if (tipo != null) 'tipo': tipo,
      if (cliente != null) 'cliente': cliente,
      if (telefono != null) 'telefono': telefono,
      if (responsable != null) 'responsable': responsable,
      if (notas != null) 'notas': notas,
      if (estado != null) 'estado': estado,
      if (creada != null) 'creada': creada,
      if (programada != null) 'programada': programada,
      if (iniciada != null) 'iniciada': iniciada,
      if (terminada != null) 'terminada': terminada,
      if (entregada != null) 'entregada': entregada,
      if (operacion != null) 'operacion': operacion,
    });
  }

  OrdenesCompanion copyWith({
    Value<int>? id,
    Value<int>? vehiculoId,
    Value<String>? patente,
    Value<String>? modelo,
    Value<String>? tipo,
    Value<String>? cliente,
    Value<String>? telefono,
    Value<String>? responsable,
    Value<String>? notas,
    Value<String>? estado,
    Value<DateTime>? creada,
    Value<DateTime?>? programada,
    Value<DateTime?>? iniciada,
    Value<DateTime?>? terminada,
    Value<DateTime?>? entregada,
    Value<String>? operacion,
  }) {
    return OrdenesCompanion(
      id: id ?? this.id,
      vehiculoId: vehiculoId ?? this.vehiculoId,
      patente: patente ?? this.patente,
      modelo: modelo ?? this.modelo,
      tipo: tipo ?? this.tipo,
      cliente: cliente ?? this.cliente,
      telefono: telefono ?? this.telefono,
      responsable: responsable ?? this.responsable,
      notas: notas ?? this.notas,
      estado: estado ?? this.estado,
      creada: creada ?? this.creada,
      programada: programada ?? this.programada,
      iniciada: iniciada ?? this.iniciada,
      terminada: terminada ?? this.terminada,
      entregada: entregada ?? this.entregada,
      operacion: operacion ?? this.operacion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehiculoId.present) {
      map['vehiculo_id'] = Variable<int>(vehiculoId.value);
    }
    if (patente.present) {
      map['patente'] = Variable<String>(patente.value);
    }
    if (modelo.present) {
      map['modelo'] = Variable<String>(modelo.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (cliente.present) {
      map['cliente'] = Variable<String>(cliente.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (responsable.present) {
      map['responsable'] = Variable<String>(responsable.value);
    }
    if (notas.present) {
      map['notas'] = Variable<String>(notas.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (creada.present) {
      map['creada'] = Variable<DateTime>(creada.value);
    }
    if (programada.present) {
      map['programada'] = Variable<DateTime>(programada.value);
    }
    if (iniciada.present) {
      map['iniciada'] = Variable<DateTime>(iniciada.value);
    }
    if (terminada.present) {
      map['terminada'] = Variable<DateTime>(terminada.value);
    }
    if (entregada.present) {
      map['entregada'] = Variable<DateTime>(entregada.value);
    }
    if (operacion.present) {
      map['operacion'] = Variable<String>(operacion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdenesCompanion(')
          ..write('id: $id, ')
          ..write('vehiculoId: $vehiculoId, ')
          ..write('patente: $patente, ')
          ..write('modelo: $modelo, ')
          ..write('tipo: $tipo, ')
          ..write('cliente: $cliente, ')
          ..write('telefono: $telefono, ')
          ..write('responsable: $responsable, ')
          ..write('notas: $notas, ')
          ..write('estado: $estado, ')
          ..write('creada: $creada, ')
          ..write('programada: $programada, ')
          ..write('iniciada: $iniciada, ')
          ..write('terminada: $terminada, ')
          ..write('entregada: $entregada, ')
          ..write('operacion: $operacion')
          ..write(')'))
        .toString();
  }
}

class $LineasOrdenTable extends LineasOrden
    with TableInfo<$LineasOrdenTable, LineaLavado> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LineasOrdenTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ordenIdMeta = const VerificationMeta(
    'ordenId',
  );
  @override
  late final GeneratedColumn<int> ordenId = GeneratedColumn<int>(
    'orden_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ordenes (id)',
    ),
  );
  static const VerificationMeta _servicioIdMeta = const VerificationMeta(
    'servicioId',
  );
  @override
  late final GeneratedColumn<int> servicioId = GeneratedColumn<int>(
    'servicio_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES servicios (id)',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioMeta = const VerificationMeta('precio');
  @override
  late final GeneratedColumn<int> precio = GeneratedColumn<int>(
    'precio',
    aliasedName,
    false,
    check: () => ComparableExpr(precio).isBiggerThanValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _duracionMeta = const VerificationMeta(
    'duracion',
  );
  @override
  late final GeneratedColumn<int> duracion = GeneratedColumn<int>(
    'duracion',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costoInsumosMeta = const VerificationMeta(
    'costoInsumos',
  );
  @override
  late final GeneratedColumn<int> costoInsumos = GeneratedColumn<int>(
    'costo_insumos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costoManoDeObraMeta = const VerificationMeta(
    'costoManoDeObra',
  );
  @override
  late final GeneratedColumn<int> costoManoDeObra = GeneratedColumn<int>(
    'costo_mano_de_obra',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recetaMeta = const VerificationMeta('receta');
  @override
  late final GeneratedColumn<String> receta = GeneratedColumn<String>(
    'receta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ordenId,
    servicioId,
    nombre,
    precio,
    duracion,
    costoInsumos,
    costoManoDeObra,
    receta,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lineas_orden';
  @override
  VerificationContext validateIntegrity(
    Insertable<LineaLavado> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('orden_id')) {
      context.handle(
        _ordenIdMeta,
        ordenId.isAcceptableOrUnknown(data['orden_id']!, _ordenIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ordenIdMeta);
    }
    if (data.containsKey('servicio_id')) {
      context.handle(
        _servicioIdMeta,
        servicioId.isAcceptableOrUnknown(data['servicio_id']!, _servicioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_servicioIdMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('precio')) {
      context.handle(
        _precioMeta,
        precio.isAcceptableOrUnknown(data['precio']!, _precioMeta),
      );
    } else if (isInserting) {
      context.missing(_precioMeta);
    }
    if (data.containsKey('duracion')) {
      context.handle(
        _duracionMeta,
        duracion.isAcceptableOrUnknown(data['duracion']!, _duracionMeta),
      );
    } else if (isInserting) {
      context.missing(_duracionMeta);
    }
    if (data.containsKey('costo_insumos')) {
      context.handle(
        _costoInsumosMeta,
        costoInsumos.isAcceptableOrUnknown(
          data['costo_insumos']!,
          _costoInsumosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_costoInsumosMeta);
    }
    if (data.containsKey('costo_mano_de_obra')) {
      context.handle(
        _costoManoDeObraMeta,
        costoManoDeObra.isAcceptableOrUnknown(
          data['costo_mano_de_obra']!,
          _costoManoDeObraMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_costoManoDeObraMeta);
    }
    if (data.containsKey('receta')) {
      context.handle(
        _recetaMeta,
        receta.isAcceptableOrUnknown(data['receta']!, _recetaMeta),
      );
    } else if (isInserting) {
      context.missing(_recetaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LineaLavado map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LineaLavado(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ordenId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}orden_id'],
      )!,
      servicioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}servicio_id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      precio: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}precio'],
      )!,
      duracion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duracion'],
      )!,
      costoInsumos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}costo_insumos'],
      )!,
      costoManoDeObra: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}costo_mano_de_obra'],
      )!,
      receta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receta'],
      )!,
    );
  }

  @override
  $LineasOrdenTable createAlias(String alias) {
    return $LineasOrdenTable(attachedDatabase, alias);
  }
}

class LineaLavado extends DataClass implements Insertable<LineaLavado> {
  final int id;
  final int ordenId;
  final int servicioId;
  final String nombre;
  final int precio;
  final int duracion;
  final int costoInsumos;
  final int costoManoDeObra;

  /// Foto de la receta: editar el catálogo nunca cambia un trabajo ya acordado.
  final String receta;
  const LineaLavado({
    required this.id,
    required this.ordenId,
    required this.servicioId,
    required this.nombre,
    required this.precio,
    required this.duracion,
    required this.costoInsumos,
    required this.costoManoDeObra,
    required this.receta,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['orden_id'] = Variable<int>(ordenId);
    map['servicio_id'] = Variable<int>(servicioId);
    map['nombre'] = Variable<String>(nombre);
    map['precio'] = Variable<int>(precio);
    map['duracion'] = Variable<int>(duracion);
    map['costo_insumos'] = Variable<int>(costoInsumos);
    map['costo_mano_de_obra'] = Variable<int>(costoManoDeObra);
    map['receta'] = Variable<String>(receta);
    return map;
  }

  LineasOrdenCompanion toCompanion(bool nullToAbsent) {
    return LineasOrdenCompanion(
      id: Value(id),
      ordenId: Value(ordenId),
      servicioId: Value(servicioId),
      nombre: Value(nombre),
      precio: Value(precio),
      duracion: Value(duracion),
      costoInsumos: Value(costoInsumos),
      costoManoDeObra: Value(costoManoDeObra),
      receta: Value(receta),
    );
  }

  factory LineaLavado.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LineaLavado(
      id: serializer.fromJson<int>(json['id']),
      ordenId: serializer.fromJson<int>(json['ordenId']),
      servicioId: serializer.fromJson<int>(json['servicioId']),
      nombre: serializer.fromJson<String>(json['nombre']),
      precio: serializer.fromJson<int>(json['precio']),
      duracion: serializer.fromJson<int>(json['duracion']),
      costoInsumos: serializer.fromJson<int>(json['costoInsumos']),
      costoManoDeObra: serializer.fromJson<int>(json['costoManoDeObra']),
      receta: serializer.fromJson<String>(json['receta']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ordenId': serializer.toJson<int>(ordenId),
      'servicioId': serializer.toJson<int>(servicioId),
      'nombre': serializer.toJson<String>(nombre),
      'precio': serializer.toJson<int>(precio),
      'duracion': serializer.toJson<int>(duracion),
      'costoInsumos': serializer.toJson<int>(costoInsumos),
      'costoManoDeObra': serializer.toJson<int>(costoManoDeObra),
      'receta': serializer.toJson<String>(receta),
    };
  }

  LineaLavado copyWith({
    int? id,
    int? ordenId,
    int? servicioId,
    String? nombre,
    int? precio,
    int? duracion,
    int? costoInsumos,
    int? costoManoDeObra,
    String? receta,
  }) => LineaLavado(
    id: id ?? this.id,
    ordenId: ordenId ?? this.ordenId,
    servicioId: servicioId ?? this.servicioId,
    nombre: nombre ?? this.nombre,
    precio: precio ?? this.precio,
    duracion: duracion ?? this.duracion,
    costoInsumos: costoInsumos ?? this.costoInsumos,
    costoManoDeObra: costoManoDeObra ?? this.costoManoDeObra,
    receta: receta ?? this.receta,
  );
  LineaLavado copyWithCompanion(LineasOrdenCompanion data) {
    return LineaLavado(
      id: data.id.present ? data.id.value : this.id,
      ordenId: data.ordenId.present ? data.ordenId.value : this.ordenId,
      servicioId: data.servicioId.present
          ? data.servicioId.value
          : this.servicioId,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      precio: data.precio.present ? data.precio.value : this.precio,
      duracion: data.duracion.present ? data.duracion.value : this.duracion,
      costoInsumos: data.costoInsumos.present
          ? data.costoInsumos.value
          : this.costoInsumos,
      costoManoDeObra: data.costoManoDeObra.present
          ? data.costoManoDeObra.value
          : this.costoManoDeObra,
      receta: data.receta.present ? data.receta.value : this.receta,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LineaLavado(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('servicioId: $servicioId, ')
          ..write('nombre: $nombre, ')
          ..write('precio: $precio, ')
          ..write('duracion: $duracion, ')
          ..write('costoInsumos: $costoInsumos, ')
          ..write('costoManoDeObra: $costoManoDeObra, ')
          ..write('receta: $receta')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ordenId,
    servicioId,
    nombre,
    precio,
    duracion,
    costoInsumos,
    costoManoDeObra,
    receta,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LineaLavado &&
          other.id == this.id &&
          other.ordenId == this.ordenId &&
          other.servicioId == this.servicioId &&
          other.nombre == this.nombre &&
          other.precio == this.precio &&
          other.duracion == this.duracion &&
          other.costoInsumos == this.costoInsumos &&
          other.costoManoDeObra == this.costoManoDeObra &&
          other.receta == this.receta);
}

class LineasOrdenCompanion extends UpdateCompanion<LineaLavado> {
  final Value<int> id;
  final Value<int> ordenId;
  final Value<int> servicioId;
  final Value<String> nombre;
  final Value<int> precio;
  final Value<int> duracion;
  final Value<int> costoInsumos;
  final Value<int> costoManoDeObra;
  final Value<String> receta;
  const LineasOrdenCompanion({
    this.id = const Value.absent(),
    this.ordenId = const Value.absent(),
    this.servicioId = const Value.absent(),
    this.nombre = const Value.absent(),
    this.precio = const Value.absent(),
    this.duracion = const Value.absent(),
    this.costoInsumos = const Value.absent(),
    this.costoManoDeObra = const Value.absent(),
    this.receta = const Value.absent(),
  });
  LineasOrdenCompanion.insert({
    this.id = const Value.absent(),
    required int ordenId,
    required int servicioId,
    required String nombre,
    required int precio,
    required int duracion,
    required int costoInsumos,
    required int costoManoDeObra,
    required String receta,
  }) : ordenId = Value(ordenId),
       servicioId = Value(servicioId),
       nombre = Value(nombre),
       precio = Value(precio),
       duracion = Value(duracion),
       costoInsumos = Value(costoInsumos),
       costoManoDeObra = Value(costoManoDeObra),
       receta = Value(receta);
  static Insertable<LineaLavado> custom({
    Expression<int>? id,
    Expression<int>? ordenId,
    Expression<int>? servicioId,
    Expression<String>? nombre,
    Expression<int>? precio,
    Expression<int>? duracion,
    Expression<int>? costoInsumos,
    Expression<int>? costoManoDeObra,
    Expression<String>? receta,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ordenId != null) 'orden_id': ordenId,
      if (servicioId != null) 'servicio_id': servicioId,
      if (nombre != null) 'nombre': nombre,
      if (precio != null) 'precio': precio,
      if (duracion != null) 'duracion': duracion,
      if (costoInsumos != null) 'costo_insumos': costoInsumos,
      if (costoManoDeObra != null) 'costo_mano_de_obra': costoManoDeObra,
      if (receta != null) 'receta': receta,
    });
  }

  LineasOrdenCompanion copyWith({
    Value<int>? id,
    Value<int>? ordenId,
    Value<int>? servicioId,
    Value<String>? nombre,
    Value<int>? precio,
    Value<int>? duracion,
    Value<int>? costoInsumos,
    Value<int>? costoManoDeObra,
    Value<String>? receta,
  }) {
    return LineasOrdenCompanion(
      id: id ?? this.id,
      ordenId: ordenId ?? this.ordenId,
      servicioId: servicioId ?? this.servicioId,
      nombre: nombre ?? this.nombre,
      precio: precio ?? this.precio,
      duracion: duracion ?? this.duracion,
      costoInsumos: costoInsumos ?? this.costoInsumos,
      costoManoDeObra: costoManoDeObra ?? this.costoManoDeObra,
      receta: receta ?? this.receta,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ordenId.present) {
      map['orden_id'] = Variable<int>(ordenId.value);
    }
    if (servicioId.present) {
      map['servicio_id'] = Variable<int>(servicioId.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (precio.present) {
      map['precio'] = Variable<int>(precio.value);
    }
    if (duracion.present) {
      map['duracion'] = Variable<int>(duracion.value);
    }
    if (costoInsumos.present) {
      map['costo_insumos'] = Variable<int>(costoInsumos.value);
    }
    if (costoManoDeObra.present) {
      map['costo_mano_de_obra'] = Variable<int>(costoManoDeObra.value);
    }
    if (receta.present) {
      map['receta'] = Variable<String>(receta.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LineasOrdenCompanion(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('servicioId: $servicioId, ')
          ..write('nombre: $nombre, ')
          ..write('precio: $precio, ')
          ..write('duracion: $duracion, ')
          ..write('costoInsumos: $costoInsumos, ')
          ..write('costoManoDeObra: $costoManoDeObra, ')
          ..write('receta: $receta')
          ..write(')'))
        .toString();
  }
}

class $MovimientosStockTable extends MovimientosStock
    with TableInfo<$MovimientosStockTable, MovimientoInsumo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovimientosStockTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _insumoIdMeta = const VerificationMeta(
    'insumoId',
  );
  @override
  late final GeneratedColumn<int> insumoId = GeneratedColumn<int>(
    'insumo_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES insumos (id)',
    ),
  );
  static const VerificationMeta _ordenIdMeta = const VerificationMeta(
    'ordenId',
  );
  @override
  late final GeneratedColumn<int> ordenId = GeneratedColumn<int>(
    'orden_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ordenes (id)',
    ),
  );
  static const VerificationMeta _anteriorMeta = const VerificationMeta(
    'anterior',
  );
  @override
  late final GeneratedColumn<int> anterior = GeneratedColumn<int>(
    'anterior',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _posteriorMeta = const VerificationMeta(
    'posterior',
  );
  @override
  late final GeneratedColumn<int> posterior = GeneratedColumn<int>(
    'posterior',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _motivoMeta = const VerificationMeta('motivo');
  @override
  late final GeneratedColumn<String> motivo = GeneratedColumn<String>(
    'motivo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    insumoId,
    ordenId,
    anterior,
    posterior,
    motivo,
    fecha,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movimientos_stock';
  @override
  VerificationContext validateIntegrity(
    Insertable<MovimientoInsumo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('insumo_id')) {
      context.handle(
        _insumoIdMeta,
        insumoId.isAcceptableOrUnknown(data['insumo_id']!, _insumoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_insumoIdMeta);
    }
    if (data.containsKey('orden_id')) {
      context.handle(
        _ordenIdMeta,
        ordenId.isAcceptableOrUnknown(data['orden_id']!, _ordenIdMeta),
      );
    }
    if (data.containsKey('anterior')) {
      context.handle(
        _anteriorMeta,
        anterior.isAcceptableOrUnknown(data['anterior']!, _anteriorMeta),
      );
    } else if (isInserting) {
      context.missing(_anteriorMeta);
    }
    if (data.containsKey('posterior')) {
      context.handle(
        _posteriorMeta,
        posterior.isAcceptableOrUnknown(data['posterior']!, _posteriorMeta),
      );
    } else if (isInserting) {
      context.missing(_posteriorMeta);
    }
    if (data.containsKey('motivo')) {
      context.handle(
        _motivoMeta,
        motivo.isAcceptableOrUnknown(data['motivo']!, _motivoMeta),
      );
    } else if (isInserting) {
      context.missing(_motivoMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MovimientoInsumo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovimientoInsumo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      insumoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}insumo_id'],
      )!,
      ordenId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}orden_id'],
      ),
      anterior: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}anterior'],
      )!,
      posterior: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}posterior'],
      )!,
      motivo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motivo'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
    );
  }

  @override
  $MovimientosStockTable createAlias(String alias) {
    return $MovimientosStockTable(attachedDatabase, alias);
  }
}

class MovimientoInsumo extends DataClass
    implements Insertable<MovimientoInsumo> {
  final int id;
  final int insumoId;
  final int? ordenId;
  final int anterior;
  final int posterior;
  final String motivo;
  final DateTime fecha;
  const MovimientoInsumo({
    required this.id,
    required this.insumoId,
    this.ordenId,
    required this.anterior,
    required this.posterior,
    required this.motivo,
    required this.fecha,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['insumo_id'] = Variable<int>(insumoId);
    if (!nullToAbsent || ordenId != null) {
      map['orden_id'] = Variable<int>(ordenId);
    }
    map['anterior'] = Variable<int>(anterior);
    map['posterior'] = Variable<int>(posterior);
    map['motivo'] = Variable<String>(motivo);
    map['fecha'] = Variable<DateTime>(fecha);
    return map;
  }

  MovimientosStockCompanion toCompanion(bool nullToAbsent) {
    return MovimientosStockCompanion(
      id: Value(id),
      insumoId: Value(insumoId),
      ordenId: ordenId == null && nullToAbsent
          ? const Value.absent()
          : Value(ordenId),
      anterior: Value(anterior),
      posterior: Value(posterior),
      motivo: Value(motivo),
      fecha: Value(fecha),
    );
  }

  factory MovimientoInsumo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovimientoInsumo(
      id: serializer.fromJson<int>(json['id']),
      insumoId: serializer.fromJson<int>(json['insumoId']),
      ordenId: serializer.fromJson<int?>(json['ordenId']),
      anterior: serializer.fromJson<int>(json['anterior']),
      posterior: serializer.fromJson<int>(json['posterior']),
      motivo: serializer.fromJson<String>(json['motivo']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'insumoId': serializer.toJson<int>(insumoId),
      'ordenId': serializer.toJson<int?>(ordenId),
      'anterior': serializer.toJson<int>(anterior),
      'posterior': serializer.toJson<int>(posterior),
      'motivo': serializer.toJson<String>(motivo),
      'fecha': serializer.toJson<DateTime>(fecha),
    };
  }

  MovimientoInsumo copyWith({
    int? id,
    int? insumoId,
    Value<int?> ordenId = const Value.absent(),
    int? anterior,
    int? posterior,
    String? motivo,
    DateTime? fecha,
  }) => MovimientoInsumo(
    id: id ?? this.id,
    insumoId: insumoId ?? this.insumoId,
    ordenId: ordenId.present ? ordenId.value : this.ordenId,
    anterior: anterior ?? this.anterior,
    posterior: posterior ?? this.posterior,
    motivo: motivo ?? this.motivo,
    fecha: fecha ?? this.fecha,
  );
  MovimientoInsumo copyWithCompanion(MovimientosStockCompanion data) {
    return MovimientoInsumo(
      id: data.id.present ? data.id.value : this.id,
      insumoId: data.insumoId.present ? data.insumoId.value : this.insumoId,
      ordenId: data.ordenId.present ? data.ordenId.value : this.ordenId,
      anterior: data.anterior.present ? data.anterior.value : this.anterior,
      posterior: data.posterior.present ? data.posterior.value : this.posterior,
      motivo: data.motivo.present ? data.motivo.value : this.motivo,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MovimientoInsumo(')
          ..write('id: $id, ')
          ..write('insumoId: $insumoId, ')
          ..write('ordenId: $ordenId, ')
          ..write('anterior: $anterior, ')
          ..write('posterior: $posterior, ')
          ..write('motivo: $motivo, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, insumoId, ordenId, anterior, posterior, motivo, fecha);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovimientoInsumo &&
          other.id == this.id &&
          other.insumoId == this.insumoId &&
          other.ordenId == this.ordenId &&
          other.anterior == this.anterior &&
          other.posterior == this.posterior &&
          other.motivo == this.motivo &&
          other.fecha == this.fecha);
}

class MovimientosStockCompanion extends UpdateCompanion<MovimientoInsumo> {
  final Value<int> id;
  final Value<int> insumoId;
  final Value<int?> ordenId;
  final Value<int> anterior;
  final Value<int> posterior;
  final Value<String> motivo;
  final Value<DateTime> fecha;
  const MovimientosStockCompanion({
    this.id = const Value.absent(),
    this.insumoId = const Value.absent(),
    this.ordenId = const Value.absent(),
    this.anterior = const Value.absent(),
    this.posterior = const Value.absent(),
    this.motivo = const Value.absent(),
    this.fecha = const Value.absent(),
  });
  MovimientosStockCompanion.insert({
    this.id = const Value.absent(),
    required int insumoId,
    this.ordenId = const Value.absent(),
    required int anterior,
    required int posterior,
    required String motivo,
    this.fecha = const Value.absent(),
  }) : insumoId = Value(insumoId),
       anterior = Value(anterior),
       posterior = Value(posterior),
       motivo = Value(motivo);
  static Insertable<MovimientoInsumo> custom({
    Expression<int>? id,
    Expression<int>? insumoId,
    Expression<int>? ordenId,
    Expression<int>? anterior,
    Expression<int>? posterior,
    Expression<String>? motivo,
    Expression<DateTime>? fecha,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (insumoId != null) 'insumo_id': insumoId,
      if (ordenId != null) 'orden_id': ordenId,
      if (anterior != null) 'anterior': anterior,
      if (posterior != null) 'posterior': posterior,
      if (motivo != null) 'motivo': motivo,
      if (fecha != null) 'fecha': fecha,
    });
  }

  MovimientosStockCompanion copyWith({
    Value<int>? id,
    Value<int>? insumoId,
    Value<int?>? ordenId,
    Value<int>? anterior,
    Value<int>? posterior,
    Value<String>? motivo,
    Value<DateTime>? fecha,
  }) {
    return MovimientosStockCompanion(
      id: id ?? this.id,
      insumoId: insumoId ?? this.insumoId,
      ordenId: ordenId ?? this.ordenId,
      anterior: anterior ?? this.anterior,
      posterior: posterior ?? this.posterior,
      motivo: motivo ?? this.motivo,
      fecha: fecha ?? this.fecha,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (insumoId.present) {
      map['insumo_id'] = Variable<int>(insumoId.value);
    }
    if (ordenId.present) {
      map['orden_id'] = Variable<int>(ordenId.value);
    }
    if (anterior.present) {
      map['anterior'] = Variable<int>(anterior.value);
    }
    if (posterior.present) {
      map['posterior'] = Variable<int>(posterior.value);
    }
    if (motivo.present) {
      map['motivo'] = Variable<String>(motivo.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovimientosStockCompanion(')
          ..write('id: $id, ')
          ..write('insumoId: $insumoId, ')
          ..write('ordenId: $ordenId, ')
          ..write('anterior: $anterior, ')
          ..write('posterior: $posterior, ')
          ..write('motivo: $motivo, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }
}

class $CajasTable extends Cajas with TableInfo<$CajasTable, SesionCaja> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CajasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _abiertaMeta = const VerificationMeta(
    'abierta',
  );
  @override
  late final GeneratedColumn<DateTime> abierta = GeneratedColumn<DateTime>(
    'abierta',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _cerradaMeta = const VerificationMeta(
    'cerrada',
  );
  @override
  late final GeneratedColumn<DateTime> cerrada = GeneratedColumn<DateTime>(
    'cerrada',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _inicialEfectivoMeta = const VerificationMeta(
    'inicialEfectivo',
  );
  @override
  late final GeneratedColumn<int> inicialEfectivo = GeneratedColumn<int>(
    'inicial_efectivo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inicialDigitalMeta = const VerificationMeta(
    'inicialDigital',
  );
  @override
  late final GeneratedColumn<int> inicialDigital = GeneratedColumn<int>(
    'inicial_digital',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contadoEfectivoMeta = const VerificationMeta(
    'contadoEfectivo',
  );
  @override
  late final GeneratedColumn<int> contadoEfectivo = GeneratedColumn<int>(
    'contado_efectivo',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contadoDigitalMeta = const VerificationMeta(
    'contadoDigital',
  );
  @override
  late final GeneratedColumn<int> contadoDigital = GeneratedColumn<int>(
    'contado_digital',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    abierta,
    cerrada,
    inicialEfectivo,
    inicialDigital,
    contadoEfectivo,
    contadoDigital,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cajas';
  @override
  VerificationContext validateIntegrity(
    Insertable<SesionCaja> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('abierta')) {
      context.handle(
        _abiertaMeta,
        abierta.isAcceptableOrUnknown(data['abierta']!, _abiertaMeta),
      );
    }
    if (data.containsKey('cerrada')) {
      context.handle(
        _cerradaMeta,
        cerrada.isAcceptableOrUnknown(data['cerrada']!, _cerradaMeta),
      );
    }
    if (data.containsKey('inicial_efectivo')) {
      context.handle(
        _inicialEfectivoMeta,
        inicialEfectivo.isAcceptableOrUnknown(
          data['inicial_efectivo']!,
          _inicialEfectivoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inicialEfectivoMeta);
    }
    if (data.containsKey('inicial_digital')) {
      context.handle(
        _inicialDigitalMeta,
        inicialDigital.isAcceptableOrUnknown(
          data['inicial_digital']!,
          _inicialDigitalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inicialDigitalMeta);
    }
    if (data.containsKey('contado_efectivo')) {
      context.handle(
        _contadoEfectivoMeta,
        contadoEfectivo.isAcceptableOrUnknown(
          data['contado_efectivo']!,
          _contadoEfectivoMeta,
        ),
      );
    }
    if (data.containsKey('contado_digital')) {
      context.handle(
        _contadoDigitalMeta,
        contadoDigital.isAcceptableOrUnknown(
          data['contado_digital']!,
          _contadoDigitalMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SesionCaja map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SesionCaja(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      abierta: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}abierta'],
      )!,
      cerrada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cerrada'],
      ),
      inicialEfectivo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}inicial_efectivo'],
      )!,
      inicialDigital: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}inicial_digital'],
      )!,
      contadoEfectivo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}contado_efectivo'],
      ),
      contadoDigital: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}contado_digital'],
      ),
    );
  }

  @override
  $CajasTable createAlias(String alias) {
    return $CajasTable(attachedDatabase, alias);
  }
}

class SesionCaja extends DataClass implements Insertable<SesionCaja> {
  final int id;
  final DateTime abierta;
  final DateTime? cerrada;
  final int inicialEfectivo;
  final int inicialDigital;
  final int? contadoEfectivo;
  final int? contadoDigital;
  const SesionCaja({
    required this.id,
    required this.abierta,
    this.cerrada,
    required this.inicialEfectivo,
    required this.inicialDigital,
    this.contadoEfectivo,
    this.contadoDigital,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['abierta'] = Variable<DateTime>(abierta);
    if (!nullToAbsent || cerrada != null) {
      map['cerrada'] = Variable<DateTime>(cerrada);
    }
    map['inicial_efectivo'] = Variable<int>(inicialEfectivo);
    map['inicial_digital'] = Variable<int>(inicialDigital);
    if (!nullToAbsent || contadoEfectivo != null) {
      map['contado_efectivo'] = Variable<int>(contadoEfectivo);
    }
    if (!nullToAbsent || contadoDigital != null) {
      map['contado_digital'] = Variable<int>(contadoDigital);
    }
    return map;
  }

  CajasCompanion toCompanion(bool nullToAbsent) {
    return CajasCompanion(
      id: Value(id),
      abierta: Value(abierta),
      cerrada: cerrada == null && nullToAbsent
          ? const Value.absent()
          : Value(cerrada),
      inicialEfectivo: Value(inicialEfectivo),
      inicialDigital: Value(inicialDigital),
      contadoEfectivo: contadoEfectivo == null && nullToAbsent
          ? const Value.absent()
          : Value(contadoEfectivo),
      contadoDigital: contadoDigital == null && nullToAbsent
          ? const Value.absent()
          : Value(contadoDigital),
    );
  }

  factory SesionCaja.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SesionCaja(
      id: serializer.fromJson<int>(json['id']),
      abierta: serializer.fromJson<DateTime>(json['abierta']),
      cerrada: serializer.fromJson<DateTime?>(json['cerrada']),
      inicialEfectivo: serializer.fromJson<int>(json['inicialEfectivo']),
      inicialDigital: serializer.fromJson<int>(json['inicialDigital']),
      contadoEfectivo: serializer.fromJson<int?>(json['contadoEfectivo']),
      contadoDigital: serializer.fromJson<int?>(json['contadoDigital']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'abierta': serializer.toJson<DateTime>(abierta),
      'cerrada': serializer.toJson<DateTime?>(cerrada),
      'inicialEfectivo': serializer.toJson<int>(inicialEfectivo),
      'inicialDigital': serializer.toJson<int>(inicialDigital),
      'contadoEfectivo': serializer.toJson<int?>(contadoEfectivo),
      'contadoDigital': serializer.toJson<int?>(contadoDigital),
    };
  }

  SesionCaja copyWith({
    int? id,
    DateTime? abierta,
    Value<DateTime?> cerrada = const Value.absent(),
    int? inicialEfectivo,
    int? inicialDigital,
    Value<int?> contadoEfectivo = const Value.absent(),
    Value<int?> contadoDigital = const Value.absent(),
  }) => SesionCaja(
    id: id ?? this.id,
    abierta: abierta ?? this.abierta,
    cerrada: cerrada.present ? cerrada.value : this.cerrada,
    inicialEfectivo: inicialEfectivo ?? this.inicialEfectivo,
    inicialDigital: inicialDigital ?? this.inicialDigital,
    contadoEfectivo: contadoEfectivo.present
        ? contadoEfectivo.value
        : this.contadoEfectivo,
    contadoDigital: contadoDigital.present
        ? contadoDigital.value
        : this.contadoDigital,
  );
  SesionCaja copyWithCompanion(CajasCompanion data) {
    return SesionCaja(
      id: data.id.present ? data.id.value : this.id,
      abierta: data.abierta.present ? data.abierta.value : this.abierta,
      cerrada: data.cerrada.present ? data.cerrada.value : this.cerrada,
      inicialEfectivo: data.inicialEfectivo.present
          ? data.inicialEfectivo.value
          : this.inicialEfectivo,
      inicialDigital: data.inicialDigital.present
          ? data.inicialDigital.value
          : this.inicialDigital,
      contadoEfectivo: data.contadoEfectivo.present
          ? data.contadoEfectivo.value
          : this.contadoEfectivo,
      contadoDigital: data.contadoDigital.present
          ? data.contadoDigital.value
          : this.contadoDigital,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SesionCaja(')
          ..write('id: $id, ')
          ..write('abierta: $abierta, ')
          ..write('cerrada: $cerrada, ')
          ..write('inicialEfectivo: $inicialEfectivo, ')
          ..write('inicialDigital: $inicialDigital, ')
          ..write('contadoEfectivo: $contadoEfectivo, ')
          ..write('contadoDigital: $contadoDigital')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    abierta,
    cerrada,
    inicialEfectivo,
    inicialDigital,
    contadoEfectivo,
    contadoDigital,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SesionCaja &&
          other.id == this.id &&
          other.abierta == this.abierta &&
          other.cerrada == this.cerrada &&
          other.inicialEfectivo == this.inicialEfectivo &&
          other.inicialDigital == this.inicialDigital &&
          other.contadoEfectivo == this.contadoEfectivo &&
          other.contadoDigital == this.contadoDigital);
}

class CajasCompanion extends UpdateCompanion<SesionCaja> {
  final Value<int> id;
  final Value<DateTime> abierta;
  final Value<DateTime?> cerrada;
  final Value<int> inicialEfectivo;
  final Value<int> inicialDigital;
  final Value<int?> contadoEfectivo;
  final Value<int?> contadoDigital;
  const CajasCompanion({
    this.id = const Value.absent(),
    this.abierta = const Value.absent(),
    this.cerrada = const Value.absent(),
    this.inicialEfectivo = const Value.absent(),
    this.inicialDigital = const Value.absent(),
    this.contadoEfectivo = const Value.absent(),
    this.contadoDigital = const Value.absent(),
  });
  CajasCompanion.insert({
    this.id = const Value.absent(),
    this.abierta = const Value.absent(),
    this.cerrada = const Value.absent(),
    required int inicialEfectivo,
    required int inicialDigital,
    this.contadoEfectivo = const Value.absent(),
    this.contadoDigital = const Value.absent(),
  }) : inicialEfectivo = Value(inicialEfectivo),
       inicialDigital = Value(inicialDigital);
  static Insertable<SesionCaja> custom({
    Expression<int>? id,
    Expression<DateTime>? abierta,
    Expression<DateTime>? cerrada,
    Expression<int>? inicialEfectivo,
    Expression<int>? inicialDigital,
    Expression<int>? contadoEfectivo,
    Expression<int>? contadoDigital,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (abierta != null) 'abierta': abierta,
      if (cerrada != null) 'cerrada': cerrada,
      if (inicialEfectivo != null) 'inicial_efectivo': inicialEfectivo,
      if (inicialDigital != null) 'inicial_digital': inicialDigital,
      if (contadoEfectivo != null) 'contado_efectivo': contadoEfectivo,
      if (contadoDigital != null) 'contado_digital': contadoDigital,
    });
  }

  CajasCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? abierta,
    Value<DateTime?>? cerrada,
    Value<int>? inicialEfectivo,
    Value<int>? inicialDigital,
    Value<int?>? contadoEfectivo,
    Value<int?>? contadoDigital,
  }) {
    return CajasCompanion(
      id: id ?? this.id,
      abierta: abierta ?? this.abierta,
      cerrada: cerrada ?? this.cerrada,
      inicialEfectivo: inicialEfectivo ?? this.inicialEfectivo,
      inicialDigital: inicialDigital ?? this.inicialDigital,
      contadoEfectivo: contadoEfectivo ?? this.contadoEfectivo,
      contadoDigital: contadoDigital ?? this.contadoDigital,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (abierta.present) {
      map['abierta'] = Variable<DateTime>(abierta.value);
    }
    if (cerrada.present) {
      map['cerrada'] = Variable<DateTime>(cerrada.value);
    }
    if (inicialEfectivo.present) {
      map['inicial_efectivo'] = Variable<int>(inicialEfectivo.value);
    }
    if (inicialDigital.present) {
      map['inicial_digital'] = Variable<int>(inicialDigital.value);
    }
    if (contadoEfectivo.present) {
      map['contado_efectivo'] = Variable<int>(contadoEfectivo.value);
    }
    if (contadoDigital.present) {
      map['contado_digital'] = Variable<int>(contadoDigital.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CajasCompanion(')
          ..write('id: $id, ')
          ..write('abierta: $abierta, ')
          ..write('cerrada: $cerrada, ')
          ..write('inicialEfectivo: $inicialEfectivo, ')
          ..write('inicialDigital: $inicialDigital, ')
          ..write('contadoEfectivo: $contadoEfectivo, ')
          ..write('contadoDigital: $contadoDigital')
          ..write(')'))
        .toString();
  }
}

class $MovimientosCajaTable extends MovimientosCaja
    with TableInfo<$MovimientosCajaTable, MovimientoCaja> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovimientosCajaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cajaIdMeta = const VerificationMeta('cajaId');
  @override
  late final GeneratedColumn<int> cajaId = GeneratedColumn<int>(
    'caja_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cajas (id)',
    ),
  );
  static const VerificationMeta _ordenIdMeta = const VerificationMeta(
    'ordenId',
  );
  @override
  late final GeneratedColumn<int> ordenId = GeneratedColumn<int>(
    'orden_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ordenes (id)',
    ),
  );
  static const VerificationMeta _medioMeta = const VerificationMeta('medio');
  @override
  late final GeneratedColumn<String> medio = GeneratedColumn<String>(
    'medio',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _montoMeta = const VerificationMeta('monto');
  @override
  late final GeneratedColumn<int> monto = GeneratedColumn<int>(
    'monto',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conceptoMeta = const VerificationMeta(
    'concepto',
  );
  @override
  late final GeneratedColumn<String> concepto = GeneratedColumn<String>(
    'concepto',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _claseMeta = const VerificationMeta('clase');
  @override
  late final GeneratedColumn<String> clase = GeneratedColumn<String>(
    'clase',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operacionMeta = const VerificationMeta(
    'operacion',
  );
  @override
  late final GeneratedColumn<String> operacion = GeneratedColumn<String>(
    'operacion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cajaId,
    ordenId,
    medio,
    monto,
    concepto,
    clase,
    operacion,
    fecha,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movimientos_caja';
  @override
  VerificationContext validateIntegrity(
    Insertable<MovimientoCaja> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('caja_id')) {
      context.handle(
        _cajaIdMeta,
        cajaId.isAcceptableOrUnknown(data['caja_id']!, _cajaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cajaIdMeta);
    }
    if (data.containsKey('orden_id')) {
      context.handle(
        _ordenIdMeta,
        ordenId.isAcceptableOrUnknown(data['orden_id']!, _ordenIdMeta),
      );
    }
    if (data.containsKey('medio')) {
      context.handle(
        _medioMeta,
        medio.isAcceptableOrUnknown(data['medio']!, _medioMeta),
      );
    } else if (isInserting) {
      context.missing(_medioMeta);
    }
    if (data.containsKey('monto')) {
      context.handle(
        _montoMeta,
        monto.isAcceptableOrUnknown(data['monto']!, _montoMeta),
      );
    } else if (isInserting) {
      context.missing(_montoMeta);
    }
    if (data.containsKey('concepto')) {
      context.handle(
        _conceptoMeta,
        concepto.isAcceptableOrUnknown(data['concepto']!, _conceptoMeta),
      );
    } else if (isInserting) {
      context.missing(_conceptoMeta);
    }
    if (data.containsKey('clase')) {
      context.handle(
        _claseMeta,
        clase.isAcceptableOrUnknown(data['clase']!, _claseMeta),
      );
    } else if (isInserting) {
      context.missing(_claseMeta);
    }
    if (data.containsKey('operacion')) {
      context.handle(
        _operacionMeta,
        operacion.isAcceptableOrUnknown(data['operacion']!, _operacionMeta),
      );
    } else if (isInserting) {
      context.missing(_operacionMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MovimientoCaja map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovimientoCaja(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      cajaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}caja_id'],
      )!,
      ordenId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}orden_id'],
      ),
      medio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}medio'],
      )!,
      monto: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monto'],
      )!,
      concepto: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}concepto'],
      )!,
      clase: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clase'],
      )!,
      operacion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operacion'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
    );
  }

  @override
  $MovimientosCajaTable createAlias(String alias) {
    return $MovimientosCajaTable(attachedDatabase, alias);
  }
}

class MovimientoCaja extends DataClass implements Insertable<MovimientoCaja> {
  final int id;
  final int cajaId;
  final int? ordenId;
  final String medio;

  /// Positivo entra, negativo sale. La devolución conserva su vínculo con la orden.
  final int monto;
  final String concepto;
  final String clase;
  final String operacion;
  final DateTime fecha;
  const MovimientoCaja({
    required this.id,
    required this.cajaId,
    this.ordenId,
    required this.medio,
    required this.monto,
    required this.concepto,
    required this.clase,
    required this.operacion,
    required this.fecha,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['caja_id'] = Variable<int>(cajaId);
    if (!nullToAbsent || ordenId != null) {
      map['orden_id'] = Variable<int>(ordenId);
    }
    map['medio'] = Variable<String>(medio);
    map['monto'] = Variable<int>(monto);
    map['concepto'] = Variable<String>(concepto);
    map['clase'] = Variable<String>(clase);
    map['operacion'] = Variable<String>(operacion);
    map['fecha'] = Variable<DateTime>(fecha);
    return map;
  }

  MovimientosCajaCompanion toCompanion(bool nullToAbsent) {
    return MovimientosCajaCompanion(
      id: Value(id),
      cajaId: Value(cajaId),
      ordenId: ordenId == null && nullToAbsent
          ? const Value.absent()
          : Value(ordenId),
      medio: Value(medio),
      monto: Value(monto),
      concepto: Value(concepto),
      clase: Value(clase),
      operacion: Value(operacion),
      fecha: Value(fecha),
    );
  }

  factory MovimientoCaja.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovimientoCaja(
      id: serializer.fromJson<int>(json['id']),
      cajaId: serializer.fromJson<int>(json['cajaId']),
      ordenId: serializer.fromJson<int?>(json['ordenId']),
      medio: serializer.fromJson<String>(json['medio']),
      monto: serializer.fromJson<int>(json['monto']),
      concepto: serializer.fromJson<String>(json['concepto']),
      clase: serializer.fromJson<String>(json['clase']),
      operacion: serializer.fromJson<String>(json['operacion']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cajaId': serializer.toJson<int>(cajaId),
      'ordenId': serializer.toJson<int?>(ordenId),
      'medio': serializer.toJson<String>(medio),
      'monto': serializer.toJson<int>(monto),
      'concepto': serializer.toJson<String>(concepto),
      'clase': serializer.toJson<String>(clase),
      'operacion': serializer.toJson<String>(operacion),
      'fecha': serializer.toJson<DateTime>(fecha),
    };
  }

  MovimientoCaja copyWith({
    int? id,
    int? cajaId,
    Value<int?> ordenId = const Value.absent(),
    String? medio,
    int? monto,
    String? concepto,
    String? clase,
    String? operacion,
    DateTime? fecha,
  }) => MovimientoCaja(
    id: id ?? this.id,
    cajaId: cajaId ?? this.cajaId,
    ordenId: ordenId.present ? ordenId.value : this.ordenId,
    medio: medio ?? this.medio,
    monto: monto ?? this.monto,
    concepto: concepto ?? this.concepto,
    clase: clase ?? this.clase,
    operacion: operacion ?? this.operacion,
    fecha: fecha ?? this.fecha,
  );
  MovimientoCaja copyWithCompanion(MovimientosCajaCompanion data) {
    return MovimientoCaja(
      id: data.id.present ? data.id.value : this.id,
      cajaId: data.cajaId.present ? data.cajaId.value : this.cajaId,
      ordenId: data.ordenId.present ? data.ordenId.value : this.ordenId,
      medio: data.medio.present ? data.medio.value : this.medio,
      monto: data.monto.present ? data.monto.value : this.monto,
      concepto: data.concepto.present ? data.concepto.value : this.concepto,
      clase: data.clase.present ? data.clase.value : this.clase,
      operacion: data.operacion.present ? data.operacion.value : this.operacion,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MovimientoCaja(')
          ..write('id: $id, ')
          ..write('cajaId: $cajaId, ')
          ..write('ordenId: $ordenId, ')
          ..write('medio: $medio, ')
          ..write('monto: $monto, ')
          ..write('concepto: $concepto, ')
          ..write('clase: $clase, ')
          ..write('operacion: $operacion, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cajaId,
    ordenId,
    medio,
    monto,
    concepto,
    clase,
    operacion,
    fecha,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovimientoCaja &&
          other.id == this.id &&
          other.cajaId == this.cajaId &&
          other.ordenId == this.ordenId &&
          other.medio == this.medio &&
          other.monto == this.monto &&
          other.concepto == this.concepto &&
          other.clase == this.clase &&
          other.operacion == this.operacion &&
          other.fecha == this.fecha);
}

class MovimientosCajaCompanion extends UpdateCompanion<MovimientoCaja> {
  final Value<int> id;
  final Value<int> cajaId;
  final Value<int?> ordenId;
  final Value<String> medio;
  final Value<int> monto;
  final Value<String> concepto;
  final Value<String> clase;
  final Value<String> operacion;
  final Value<DateTime> fecha;
  const MovimientosCajaCompanion({
    this.id = const Value.absent(),
    this.cajaId = const Value.absent(),
    this.ordenId = const Value.absent(),
    this.medio = const Value.absent(),
    this.monto = const Value.absent(),
    this.concepto = const Value.absent(),
    this.clase = const Value.absent(),
    this.operacion = const Value.absent(),
    this.fecha = const Value.absent(),
  });
  MovimientosCajaCompanion.insert({
    this.id = const Value.absent(),
    required int cajaId,
    this.ordenId = const Value.absent(),
    required String medio,
    required int monto,
    required String concepto,
    required String clase,
    required String operacion,
    this.fecha = const Value.absent(),
  }) : cajaId = Value(cajaId),
       medio = Value(medio),
       monto = Value(monto),
       concepto = Value(concepto),
       clase = Value(clase),
       operacion = Value(operacion);
  static Insertable<MovimientoCaja> custom({
    Expression<int>? id,
    Expression<int>? cajaId,
    Expression<int>? ordenId,
    Expression<String>? medio,
    Expression<int>? monto,
    Expression<String>? concepto,
    Expression<String>? clase,
    Expression<String>? operacion,
    Expression<DateTime>? fecha,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cajaId != null) 'caja_id': cajaId,
      if (ordenId != null) 'orden_id': ordenId,
      if (medio != null) 'medio': medio,
      if (monto != null) 'monto': monto,
      if (concepto != null) 'concepto': concepto,
      if (clase != null) 'clase': clase,
      if (operacion != null) 'operacion': operacion,
      if (fecha != null) 'fecha': fecha,
    });
  }

  MovimientosCajaCompanion copyWith({
    Value<int>? id,
    Value<int>? cajaId,
    Value<int?>? ordenId,
    Value<String>? medio,
    Value<int>? monto,
    Value<String>? concepto,
    Value<String>? clase,
    Value<String>? operacion,
    Value<DateTime>? fecha,
  }) {
    return MovimientosCajaCompanion(
      id: id ?? this.id,
      cajaId: cajaId ?? this.cajaId,
      ordenId: ordenId ?? this.ordenId,
      medio: medio ?? this.medio,
      monto: monto ?? this.monto,
      concepto: concepto ?? this.concepto,
      clase: clase ?? this.clase,
      operacion: operacion ?? this.operacion,
      fecha: fecha ?? this.fecha,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cajaId.present) {
      map['caja_id'] = Variable<int>(cajaId.value);
    }
    if (ordenId.present) {
      map['orden_id'] = Variable<int>(ordenId.value);
    }
    if (medio.present) {
      map['medio'] = Variable<String>(medio.value);
    }
    if (monto.present) {
      map['monto'] = Variable<int>(monto.value);
    }
    if (concepto.present) {
      map['concepto'] = Variable<String>(concepto.value);
    }
    if (clase.present) {
      map['clase'] = Variable<String>(clase.value);
    }
    if (operacion.present) {
      map['operacion'] = Variable<String>(operacion.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovimientosCajaCompanion(')
          ..write('id: $id, ')
          ..write('cajaId: $cajaId, ')
          ..write('ordenId: $ordenId, ')
          ..write('medio: $medio, ')
          ..write('monto: $monto, ')
          ..write('concepto: $concepto, ')
          ..write('clase: $clase, ')
          ..write('operacion: $operacion, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }
}

abstract class _$LavaderoDatabase extends GeneratedDatabase {
  _$LavaderoDatabase(QueryExecutor e) : super(e);
  $LavaderoDatabaseManager get managers => $LavaderoDatabaseManager(this);
  late final $AjustesTable ajustes = $AjustesTable(this);
  late final $InsumosTable insumos = $InsumosTable(this);
  late final $ServiciosTable servicios = $ServiciosTable(this);
  late final $TarifasTable tarifas = $TarifasTable(this);
  late final $RecetasTable recetas = $RecetasTable(this);
  late final $VehiculosTable vehiculos = $VehiculosTable(this);
  late final $OrdenesTable ordenes = $OrdenesTable(this);
  late final $LineasOrdenTable lineasOrden = $LineasOrdenTable(this);
  late final $MovimientosStockTable movimientosStock = $MovimientosStockTable(
    this,
  );
  late final $CajasTable cajas = $CajasTable(this);
  late final $MovimientosCajaTable movimientosCaja = $MovimientosCajaTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    ajustes,
    insumos,
    servicios,
    tarifas,
    recetas,
    vehiculos,
    ordenes,
    lineasOrden,
    movimientosStock,
    cajas,
    movimientosCaja,
  ];
}

typedef $$AjustesTableCreateCompanionBuilder =
    AjustesCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String> alias,
      Value<int> valorHora,
    });
typedef $$AjustesTableUpdateCompanionBuilder =
    AjustesCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String> alias,
      Value<int> valorHora,
    });

class $$AjustesTableFilterComposer
    extends Composer<_$LavaderoDatabase, $AjustesTable> {
  $$AjustesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alias => $composableBuilder(
    column: $table.alias,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get valorHora => $composableBuilder(
    column: $table.valorHora,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AjustesTableOrderingComposer
    extends Composer<_$LavaderoDatabase, $AjustesTable> {
  $$AjustesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alias => $composableBuilder(
    column: $table.alias,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get valorHora => $composableBuilder(
    column: $table.valorHora,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AjustesTableAnnotationComposer
    extends Composer<_$LavaderoDatabase, $AjustesTable> {
  $$AjustesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get alias =>
      $composableBuilder(column: $table.alias, builder: (column) => column);

  GeneratedColumn<int> get valorHora =>
      $composableBuilder(column: $table.valorHora, builder: (column) => column);
}

class $$AjustesTableTableManager
    extends
        RootTableManager<
          _$LavaderoDatabase,
          $AjustesTable,
          Ajuste,
          $$AjustesTableFilterComposer,
          $$AjustesTableOrderingComposer,
          $$AjustesTableAnnotationComposer,
          $$AjustesTableCreateCompanionBuilder,
          $$AjustesTableUpdateCompanionBuilder,
          (Ajuste, BaseReferences<_$LavaderoDatabase, $AjustesTable, Ajuste>),
          Ajuste,
          PrefetchHooks Function()
        > {
  $$AjustesTableTableManager(_$LavaderoDatabase db, $AjustesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AjustesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AjustesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AjustesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> alias = const Value.absent(),
                Value<int> valorHora = const Value.absent(),
              }) => AjustesCompanion(
                id: id,
                nombre: nombre,
                alias: alias,
                valorHora: valorHora,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> alias = const Value.absent(),
                Value<int> valorHora = const Value.absent(),
              }) => AjustesCompanion.insert(
                id: id,
                nombre: nombre,
                alias: alias,
                valorHora: valorHora,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AjustesTable, Ajuste>(table),
                  BaseReferences<_$LavaderoDatabase, $AjustesTable, Ajuste>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AjustesTableProcessedTableManager =
    ProcessedTableManager<
      _$LavaderoDatabase,
      $AjustesTable,
      Ajuste,
      $$AjustesTableFilterComposer,
      $$AjustesTableOrderingComposer,
      $$AjustesTableAnnotationComposer,
      $$AjustesTableCreateCompanionBuilder,
      $$AjustesTableUpdateCompanionBuilder,
      (Ajuste, BaseReferences<_$LavaderoDatabase, $AjustesTable, Ajuste>),
      Ajuste,
      PrefetchHooks Function()
    >;
typedef $$InsumosTableCreateCompanionBuilder =
    InsumosCompanion Function({
      Value<int> id,
      required String nombre,
      required String unidad,
      required int contenido,
      required int costoEnvase,
      Value<int> stock,
      Value<int> minimo,
      Value<bool> activo,
    });
typedef $$InsumosTableUpdateCompanionBuilder =
    InsumosCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String> unidad,
      Value<int> contenido,
      Value<int> costoEnvase,
      Value<int> stock,
      Value<int> minimo,
      Value<bool> activo,
    });

final class $$InsumosTableReferences
    extends BaseReferences<_$LavaderoDatabase, $InsumosTable, Insumo> {
  $$InsumosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RecetasTable, List<Receta>> _recetasRefsTable(
    _$LavaderoDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.recetas,
    aliasName: 'insumos__id__recetas__insumo_id',
  );

  $$RecetasTableProcessedTableManager get recetasRefs {
    final manager = $$RecetasTableTableManager(
      $_db,
      $_db.recetas,
    ).filter((f) => f.insumoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_recetasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MovimientosStockTable, List<MovimientoInsumo>>
  _movimientosStockRefsTable(_$LavaderoDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.movimientosStock,
        aliasName: 'insumos__id__movimientos_stock__insumo_id',
      );

  $$MovimientosStockTableProcessedTableManager get movimientosStockRefs {
    final manager = $$MovimientosStockTableTableManager(
      $_db,
      $_db.movimientosStock,
    ).filter((f) => f.insumoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _movimientosStockRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InsumosTableFilterComposer
    extends Composer<_$LavaderoDatabase, $InsumosTable> {
  $$InsumosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unidad => $composableBuilder(
    column: $table.unidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get contenido => $composableBuilder(
    column: $table.contenido,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costoEnvase => $composableBuilder(
    column: $table.costoEnvase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stock => $composableBuilder(
    column: $table.stock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minimo => $composableBuilder(
    column: $table.minimo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> recetasRefs(
    Expression<bool> Function($$RecetasTableFilterComposer f) f,
  ) {
    final $$RecetasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recetas,
      getReferencedColumn: (t) => t.insumoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecetasTableFilterComposer(
            $db: $db,
            $table: $db.recetas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> movimientosStockRefs(
    Expression<bool> Function($$MovimientosStockTableFilterComposer f) f,
  ) {
    final $$MovimientosStockTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movimientosStock,
      getReferencedColumn: (t) => t.insumoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovimientosStockTableFilterComposer(
            $db: $db,
            $table: $db.movimientosStock,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InsumosTableOrderingComposer
    extends Composer<_$LavaderoDatabase, $InsumosTable> {
  $$InsumosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unidad => $composableBuilder(
    column: $table.unidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get contenido => $composableBuilder(
    column: $table.contenido,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costoEnvase => $composableBuilder(
    column: $table.costoEnvase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stock => $composableBuilder(
    column: $table.stock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minimo => $composableBuilder(
    column: $table.minimo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InsumosTableAnnotationComposer
    extends Composer<_$LavaderoDatabase, $InsumosTable> {
  $$InsumosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get unidad =>
      $composableBuilder(column: $table.unidad, builder: (column) => column);

  GeneratedColumn<int> get contenido =>
      $composableBuilder(column: $table.contenido, builder: (column) => column);

  GeneratedColumn<int> get costoEnvase => $composableBuilder(
    column: $table.costoEnvase,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stock =>
      $composableBuilder(column: $table.stock, builder: (column) => column);

  GeneratedColumn<int> get minimo =>
      $composableBuilder(column: $table.minimo, builder: (column) => column);

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  Expression<T> recetasRefs<T extends Object>(
    Expression<T> Function($$RecetasTableAnnotationComposer a) f,
  ) {
    final $$RecetasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recetas,
      getReferencedColumn: (t) => t.insumoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecetasTableAnnotationComposer(
            $db: $db,
            $table: $db.recetas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> movimientosStockRefs<T extends Object>(
    Expression<T> Function($$MovimientosStockTableAnnotationComposer a) f,
  ) {
    final $$MovimientosStockTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movimientosStock,
      getReferencedColumn: (t) => t.insumoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovimientosStockTableAnnotationComposer(
            $db: $db,
            $table: $db.movimientosStock,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InsumosTableTableManager
    extends
        RootTableManager<
          _$LavaderoDatabase,
          $InsumosTable,
          Insumo,
          $$InsumosTableFilterComposer,
          $$InsumosTableOrderingComposer,
          $$InsumosTableAnnotationComposer,
          $$InsumosTableCreateCompanionBuilder,
          $$InsumosTableUpdateCompanionBuilder,
          (Insumo, $$InsumosTableReferences),
          Insumo,
          PrefetchHooks Function({bool recetasRefs, bool movimientosStockRefs})
        > {
  $$InsumosTableTableManager(_$LavaderoDatabase db, $InsumosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InsumosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InsumosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InsumosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> unidad = const Value.absent(),
                Value<int> contenido = const Value.absent(),
                Value<int> costoEnvase = const Value.absent(),
                Value<int> stock = const Value.absent(),
                Value<int> minimo = const Value.absent(),
                Value<bool> activo = const Value.absent(),
              }) => InsumosCompanion(
                id: id,
                nombre: nombre,
                unidad: unidad,
                contenido: contenido,
                costoEnvase: costoEnvase,
                stock: stock,
                minimo: minimo,
                activo: activo,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required String unidad,
                required int contenido,
                required int costoEnvase,
                Value<int> stock = const Value.absent(),
                Value<int> minimo = const Value.absent(),
                Value<bool> activo = const Value.absent(),
              }) => InsumosCompanion.insert(
                id: id,
                nombre: nombre,
                unidad: unidad,
                contenido: contenido,
                costoEnvase: costoEnvase,
                stock: stock,
                minimo: minimo,
                activo: activo,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InsumosTable, Insumo>(table),
                  $$InsumosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({recetasRefs = false, movimientosStockRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recetasRefs) db.recetas,
                    if (movimientosStockRefs) db.movimientosStock,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recetasRefs)
                        await $_getPrefetchedDataByColumns<
                          Insumo,
                          $InsumosTable,
                          Receta,
                          $RecetasTable
                        >(
                          currentTable: table,
                          referencedTable: $$InsumosTableReferences
                              ._recetasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InsumosTableReferences(
                                db,
                                table,
                                p0,
                              ).recetasRefs,
                          currentColumn: 'id',
                          referencedColumn: 'insumo_id',
                          typedResults: items,
                        ),
                      if (movimientosStockRefs)
                        await $_getPrefetchedDataByColumns<
                          Insumo,
                          $InsumosTable,
                          MovimientoInsumo,
                          $MovimientosStockTable
                        >(
                          currentTable: table,
                          referencedTable: $$InsumosTableReferences
                              ._movimientosStockRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InsumosTableReferences(
                                db,
                                table,
                                p0,
                              ).movimientosStockRefs,
                          currentColumn: 'id',
                          referencedColumn: 'insumo_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$InsumosTableProcessedTableManager =
    ProcessedTableManager<
      _$LavaderoDatabase,
      $InsumosTable,
      Insumo,
      $$InsumosTableFilterComposer,
      $$InsumosTableOrderingComposer,
      $$InsumosTableAnnotationComposer,
      $$InsumosTableCreateCompanionBuilder,
      $$InsumosTableUpdateCompanionBuilder,
      (Insumo, $$InsumosTableReferences),
      Insumo,
      PrefetchHooks Function({bool recetasRefs, bool movimientosStockRefs})
    >;
typedef $$ServiciosTableCreateCompanionBuilder =
    ServiciosCompanion Function({
      Value<int> id,
      required String nombre,
      required int duracion,
      Value<bool> manoDeObra,
      Value<int> gananciaBuscada,
      Value<bool> activo,
    });
typedef $$ServiciosTableUpdateCompanionBuilder =
    ServiciosCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<int> duracion,
      Value<bool> manoDeObra,
      Value<int> gananciaBuscada,
      Value<bool> activo,
    });

final class $$ServiciosTableReferences
    extends BaseReferences<_$LavaderoDatabase, $ServiciosTable, Servicio> {
  $$ServiciosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TarifasTable, List<Tarifa>> _tarifasRefsTable(
    _$LavaderoDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tarifas,
    aliasName: 'servicios__id__tarifas__servicio_id',
  );

  $$TarifasTableProcessedTableManager get tarifasRefs {
    final manager = $$TarifasTableTableManager(
      $_db,
      $_db.tarifas,
    ).filter((f) => f.servicioId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_tarifasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RecetasTable, List<Receta>> _recetasRefsTable(
    _$LavaderoDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.recetas,
    aliasName: 'servicios__id__recetas__servicio_id',
  );

  $$RecetasTableProcessedTableManager get recetasRefs {
    final manager = $$RecetasTableTableManager(
      $_db,
      $_db.recetas,
    ).filter((f) => f.servicioId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_recetasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LineasOrdenTable, List<LineaLavado>>
  _lineasOrdenRefsTable(_$LavaderoDatabase db) => MultiTypedResultKey.fromTable(
    db.lineasOrden,
    aliasName: 'servicios__id__lineas_orden__servicio_id',
  );

  $$LineasOrdenTableProcessedTableManager get lineasOrdenRefs {
    final manager = $$LineasOrdenTableTableManager(
      $_db,
      $_db.lineasOrden,
    ).filter((f) => f.servicioId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_lineasOrdenRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ServiciosTableFilterComposer
    extends Composer<_$LavaderoDatabase, $ServiciosTable> {
  $$ServiciosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duracion => $composableBuilder(
    column: $table.duracion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get manoDeObra => $composableBuilder(
    column: $table.manoDeObra,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gananciaBuscada => $composableBuilder(
    column: $table.gananciaBuscada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> tarifasRefs(
    Expression<bool> Function($$TarifasTableFilterComposer f) f,
  ) {
    final $$TarifasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tarifas,
      getReferencedColumn: (t) => t.servicioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TarifasTableFilterComposer(
            $db: $db,
            $table: $db.tarifas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recetasRefs(
    Expression<bool> Function($$RecetasTableFilterComposer f) f,
  ) {
    final $$RecetasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recetas,
      getReferencedColumn: (t) => t.servicioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecetasTableFilterComposer(
            $db: $db,
            $table: $db.recetas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> lineasOrdenRefs(
    Expression<bool> Function($$LineasOrdenTableFilterComposer f) f,
  ) {
    final $$LineasOrdenTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lineasOrden,
      getReferencedColumn: (t) => t.servicioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LineasOrdenTableFilterComposer(
            $db: $db,
            $table: $db.lineasOrden,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ServiciosTableOrderingComposer
    extends Composer<_$LavaderoDatabase, $ServiciosTable> {
  $$ServiciosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duracion => $composableBuilder(
    column: $table.duracion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get manoDeObra => $composableBuilder(
    column: $table.manoDeObra,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gananciaBuscada => $composableBuilder(
    column: $table.gananciaBuscada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ServiciosTableAnnotationComposer
    extends Composer<_$LavaderoDatabase, $ServiciosTable> {
  $$ServiciosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<int> get duracion =>
      $composableBuilder(column: $table.duracion, builder: (column) => column);

  GeneratedColumn<bool> get manoDeObra => $composableBuilder(
    column: $table.manoDeObra,
    builder: (column) => column,
  );

  GeneratedColumn<int> get gananciaBuscada => $composableBuilder(
    column: $table.gananciaBuscada,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  Expression<T> tarifasRefs<T extends Object>(
    Expression<T> Function($$TarifasTableAnnotationComposer a) f,
  ) {
    final $$TarifasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tarifas,
      getReferencedColumn: (t) => t.servicioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TarifasTableAnnotationComposer(
            $db: $db,
            $table: $db.tarifas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recetasRefs<T extends Object>(
    Expression<T> Function($$RecetasTableAnnotationComposer a) f,
  ) {
    final $$RecetasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recetas,
      getReferencedColumn: (t) => t.servicioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecetasTableAnnotationComposer(
            $db: $db,
            $table: $db.recetas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> lineasOrdenRefs<T extends Object>(
    Expression<T> Function($$LineasOrdenTableAnnotationComposer a) f,
  ) {
    final $$LineasOrdenTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lineasOrden,
      getReferencedColumn: (t) => t.servicioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LineasOrdenTableAnnotationComposer(
            $db: $db,
            $table: $db.lineasOrden,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ServiciosTableTableManager
    extends
        RootTableManager<
          _$LavaderoDatabase,
          $ServiciosTable,
          Servicio,
          $$ServiciosTableFilterComposer,
          $$ServiciosTableOrderingComposer,
          $$ServiciosTableAnnotationComposer,
          $$ServiciosTableCreateCompanionBuilder,
          $$ServiciosTableUpdateCompanionBuilder,
          (Servicio, $$ServiciosTableReferences),
          Servicio,
          PrefetchHooks Function({
            bool tarifasRefs,
            bool recetasRefs,
            bool lineasOrdenRefs,
          })
        > {
  $$ServiciosTableTableManager(_$LavaderoDatabase db, $ServiciosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServiciosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServiciosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServiciosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<int> duracion = const Value.absent(),
                Value<bool> manoDeObra = const Value.absent(),
                Value<int> gananciaBuscada = const Value.absent(),
                Value<bool> activo = const Value.absent(),
              }) => ServiciosCompanion(
                id: id,
                nombre: nombre,
                duracion: duracion,
                manoDeObra: manoDeObra,
                gananciaBuscada: gananciaBuscada,
                activo: activo,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required int duracion,
                Value<bool> manoDeObra = const Value.absent(),
                Value<int> gananciaBuscada = const Value.absent(),
                Value<bool> activo = const Value.absent(),
              }) => ServiciosCompanion.insert(
                id: id,
                nombre: nombre,
                duracion: duracion,
                manoDeObra: manoDeObra,
                gananciaBuscada: gananciaBuscada,
                activo: activo,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ServiciosTable, Servicio>(table),
                  $$ServiciosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                tarifasRefs = false,
                recetasRefs = false,
                lineasOrdenRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (tarifasRefs) db.tarifas,
                    if (recetasRefs) db.recetas,
                    if (lineasOrdenRefs) db.lineasOrden,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (tarifasRefs)
                        await $_getPrefetchedDataByColumns<
                          Servicio,
                          $ServiciosTable,
                          Tarifa,
                          $TarifasTable
                        >(
                          currentTable: table,
                          referencedTable: $$ServiciosTableReferences
                              ._tarifasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ServiciosTableReferences(
                                db,
                                table,
                                p0,
                              ).tarifasRefs,
                          currentColumn: 'id',
                          referencedColumn: 'servicio_id',
                          typedResults: items,
                        ),
                      if (recetasRefs)
                        await $_getPrefetchedDataByColumns<
                          Servicio,
                          $ServiciosTable,
                          Receta,
                          $RecetasTable
                        >(
                          currentTable: table,
                          referencedTable: $$ServiciosTableReferences
                              ._recetasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ServiciosTableReferences(
                                db,
                                table,
                                p0,
                              ).recetasRefs,
                          currentColumn: 'id',
                          referencedColumn: 'servicio_id',
                          typedResults: items,
                        ),
                      if (lineasOrdenRefs)
                        await $_getPrefetchedDataByColumns<
                          Servicio,
                          $ServiciosTable,
                          LineaLavado,
                          $LineasOrdenTable
                        >(
                          currentTable: table,
                          referencedTable: $$ServiciosTableReferences
                              ._lineasOrdenRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ServiciosTableReferences(
                                db,
                                table,
                                p0,
                              ).lineasOrdenRefs,
                          currentColumn: 'id',
                          referencedColumn: 'servicio_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ServiciosTableProcessedTableManager =
    ProcessedTableManager<
      _$LavaderoDatabase,
      $ServiciosTable,
      Servicio,
      $$ServiciosTableFilterComposer,
      $$ServiciosTableOrderingComposer,
      $$ServiciosTableAnnotationComposer,
      $$ServiciosTableCreateCompanionBuilder,
      $$ServiciosTableUpdateCompanionBuilder,
      (Servicio, $$ServiciosTableReferences),
      Servicio,
      PrefetchHooks Function({
        bool tarifasRefs,
        bool recetasRefs,
        bool lineasOrdenRefs,
      })
    >;
typedef $$TarifasTableCreateCompanionBuilder =
    TarifasCompanion Function({
      required int servicioId,
      required String tipo,
      required int precio,
      Value<int> rowid,
    });
typedef $$TarifasTableUpdateCompanionBuilder =
    TarifasCompanion Function({
      Value<int> servicioId,
      Value<String> tipo,
      Value<int> precio,
      Value<int> rowid,
    });

final class $$TarifasTableReferences
    extends BaseReferences<_$LavaderoDatabase, $TarifasTable, Tarifa> {
  $$TarifasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ServiciosTable _servicioIdTable(_$LavaderoDatabase db) =>
      db.servicios.createAlias('tarifas__servicio_id__servicios__id');

  $$ServiciosTableProcessedTableManager get servicioId {
    final $_column = $_itemColumn<int>('servicio_id')!;

    final manager = $$ServiciosTableTableManager(
      $_db,
      $_db.servicios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_servicioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TarifasTableFilterComposer
    extends Composer<_$LavaderoDatabase, $TarifasTable> {
  $$TarifasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get precio => $composableBuilder(
    column: $table.precio,
    builder: (column) => ColumnFilters(column),
  );

  $$ServiciosTableFilterComposer get servicioId {
    final $$ServiciosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.servicioId,
      referencedTable: $db.servicios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiciosTableFilterComposer(
            $db: $db,
            $table: $db.servicios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TarifasTableOrderingComposer
    extends Composer<_$LavaderoDatabase, $TarifasTable> {
  $$TarifasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get precio => $composableBuilder(
    column: $table.precio,
    builder: (column) => ColumnOrderings(column),
  );

  $$ServiciosTableOrderingComposer get servicioId {
    final $$ServiciosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.servicioId,
      referencedTable: $db.servicios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiciosTableOrderingComposer(
            $db: $db,
            $table: $db.servicios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TarifasTableAnnotationComposer
    extends Composer<_$LavaderoDatabase, $TarifasTable> {
  $$TarifasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<int> get precio =>
      $composableBuilder(column: $table.precio, builder: (column) => column);

  $$ServiciosTableAnnotationComposer get servicioId {
    final $$ServiciosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.servicioId,
      referencedTable: $db.servicios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiciosTableAnnotationComposer(
            $db: $db,
            $table: $db.servicios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TarifasTableTableManager
    extends
        RootTableManager<
          _$LavaderoDatabase,
          $TarifasTable,
          Tarifa,
          $$TarifasTableFilterComposer,
          $$TarifasTableOrderingComposer,
          $$TarifasTableAnnotationComposer,
          $$TarifasTableCreateCompanionBuilder,
          $$TarifasTableUpdateCompanionBuilder,
          (Tarifa, $$TarifasTableReferences),
          Tarifa,
          PrefetchHooks Function({bool servicioId})
        > {
  $$TarifasTableTableManager(_$LavaderoDatabase db, $TarifasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TarifasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TarifasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TarifasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> servicioId = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<int> precio = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TarifasCompanion(
                servicioId: servicioId,
                tipo: tipo,
                precio: precio,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int servicioId,
                required String tipo,
                required int precio,
                Value<int> rowid = const Value.absent(),
              }) => TarifasCompanion.insert(
                servicioId: servicioId,
                tipo: tipo,
                precio: precio,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TarifasTable, Tarifa>(table),
                  $$TarifasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({servicioId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (servicioId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.servicioId,
                                referencedTable: $$TarifasTableReferences
                                    ._servicioIdTable(db),
                                referencedColumn: $$TarifasTableReferences
                                    ._servicioIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TarifasTableProcessedTableManager =
    ProcessedTableManager<
      _$LavaderoDatabase,
      $TarifasTable,
      Tarifa,
      $$TarifasTableFilterComposer,
      $$TarifasTableOrderingComposer,
      $$TarifasTableAnnotationComposer,
      $$TarifasTableCreateCompanionBuilder,
      $$TarifasTableUpdateCompanionBuilder,
      (Tarifa, $$TarifasTableReferences),
      Tarifa,
      PrefetchHooks Function({bool servicioId})
    >;
typedef $$RecetasTableCreateCompanionBuilder =
    RecetasCompanion Function({
      required int servicioId,
      required int insumoId,
      required int cantidad,
      Value<int> rowid,
    });
typedef $$RecetasTableUpdateCompanionBuilder =
    RecetasCompanion Function({
      Value<int> servicioId,
      Value<int> insumoId,
      Value<int> cantidad,
      Value<int> rowid,
    });

final class $$RecetasTableReferences
    extends BaseReferences<_$LavaderoDatabase, $RecetasTable, Receta> {
  $$RecetasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ServiciosTable _servicioIdTable(_$LavaderoDatabase db) =>
      db.servicios.createAlias('recetas__servicio_id__servicios__id');

  $$ServiciosTableProcessedTableManager get servicioId {
    final $_column = $_itemColumn<int>('servicio_id')!;

    final manager = $$ServiciosTableTableManager(
      $_db,
      $_db.servicios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_servicioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InsumosTable _insumoIdTable(_$LavaderoDatabase db) =>
      db.insumos.createAlias('recetas__insumo_id__insumos__id');

  $$InsumosTableProcessedTableManager get insumoId {
    final $_column = $_itemColumn<int>('insumo_id')!;

    final manager = $$InsumosTableTableManager(
      $_db,
      $_db.insumos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_insumoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecetasTableFilterComposer
    extends Composer<_$LavaderoDatabase, $RecetasTable> {
  $$RecetasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  $$ServiciosTableFilterComposer get servicioId {
    final $$ServiciosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.servicioId,
      referencedTable: $db.servicios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiciosTableFilterComposer(
            $db: $db,
            $table: $db.servicios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InsumosTableFilterComposer get insumoId {
    final $$InsumosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.insumoId,
      referencedTable: $db.insumos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InsumosTableFilterComposer(
            $db: $db,
            $table: $db.insumos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecetasTableOrderingComposer
    extends Composer<_$LavaderoDatabase, $RecetasTable> {
  $$RecetasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  $$ServiciosTableOrderingComposer get servicioId {
    final $$ServiciosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.servicioId,
      referencedTable: $db.servicios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiciosTableOrderingComposer(
            $db: $db,
            $table: $db.servicios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InsumosTableOrderingComposer get insumoId {
    final $$InsumosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.insumoId,
      referencedTable: $db.insumos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InsumosTableOrderingComposer(
            $db: $db,
            $table: $db.insumos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecetasTableAnnotationComposer
    extends Composer<_$LavaderoDatabase, $RecetasTable> {
  $$RecetasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  $$ServiciosTableAnnotationComposer get servicioId {
    final $$ServiciosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.servicioId,
      referencedTable: $db.servicios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiciosTableAnnotationComposer(
            $db: $db,
            $table: $db.servicios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InsumosTableAnnotationComposer get insumoId {
    final $$InsumosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.insumoId,
      referencedTable: $db.insumos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InsumosTableAnnotationComposer(
            $db: $db,
            $table: $db.insumos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecetasTableTableManager
    extends
        RootTableManager<
          _$LavaderoDatabase,
          $RecetasTable,
          Receta,
          $$RecetasTableFilterComposer,
          $$RecetasTableOrderingComposer,
          $$RecetasTableAnnotationComposer,
          $$RecetasTableCreateCompanionBuilder,
          $$RecetasTableUpdateCompanionBuilder,
          (Receta, $$RecetasTableReferences),
          Receta,
          PrefetchHooks Function({bool servicioId, bool insumoId})
        > {
  $$RecetasTableTableManager(_$LavaderoDatabase db, $RecetasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecetasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecetasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecetasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> servicioId = const Value.absent(),
                Value<int> insumoId = const Value.absent(),
                Value<int> cantidad = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecetasCompanion(
                servicioId: servicioId,
                insumoId: insumoId,
                cantidad: cantidad,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int servicioId,
                required int insumoId,
                required int cantidad,
                Value<int> rowid = const Value.absent(),
              }) => RecetasCompanion.insert(
                servicioId: servicioId,
                insumoId: insumoId,
                cantidad: cantidad,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecetasTable, Receta>(table),
                  $$RecetasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({servicioId = false, insumoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (servicioId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.servicioId,
                                referencedTable: $$RecetasTableReferences
                                    ._servicioIdTable(db),
                                referencedColumn: $$RecetasTableReferences
                                    ._servicioIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (insumoId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.insumoId,
                                referencedTable: $$RecetasTableReferences
                                    ._insumoIdTable(db),
                                referencedColumn: $$RecetasTableReferences
                                    ._insumoIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecetasTableProcessedTableManager =
    ProcessedTableManager<
      _$LavaderoDatabase,
      $RecetasTable,
      Receta,
      $$RecetasTableFilterComposer,
      $$RecetasTableOrderingComposer,
      $$RecetasTableAnnotationComposer,
      $$RecetasTableCreateCompanionBuilder,
      $$RecetasTableUpdateCompanionBuilder,
      (Receta, $$RecetasTableReferences),
      Receta,
      PrefetchHooks Function({bool servicioId, bool insumoId})
    >;
typedef $$VehiculosTableCreateCompanionBuilder =
    VehiculosCompanion Function({
      Value<int> id,
      required String patente,
      required String modelo,
      required String tipo,
      Value<String> cliente,
      Value<String> telefono,
      Value<String> notas,
    });
typedef $$VehiculosTableUpdateCompanionBuilder =
    VehiculosCompanion Function({
      Value<int> id,
      Value<String> patente,
      Value<String> modelo,
      Value<String> tipo,
      Value<String> cliente,
      Value<String> telefono,
      Value<String> notas,
    });

final class $$VehiculosTableReferences
    extends BaseReferences<_$LavaderoDatabase, $VehiculosTable, Vehiculo> {
  $$VehiculosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$OrdenesTable, List<OrdenLavado>>
  _ordenesRefsTable(_$LavaderoDatabase db) => MultiTypedResultKey.fromTable(
    db.ordenes,
    aliasName: 'vehiculos__id__ordenes__vehiculo_id',
  );

  $$OrdenesTableProcessedTableManager get ordenesRefs {
    final manager = $$OrdenesTableTableManager(
      $_db,
      $_db.ordenes,
    ).filter((f) => f.vehiculoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ordenesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VehiculosTableFilterComposer
    extends Composer<_$LavaderoDatabase, $VehiculosTable> {
  $$VehiculosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patente => $composableBuilder(
    column: $table.patente,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelo => $composableBuilder(
    column: $table.modelo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cliente => $composableBuilder(
    column: $table.cliente,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notas => $composableBuilder(
    column: $table.notas,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ordenesRefs(
    Expression<bool> Function($$OrdenesTableFilterComposer f) f,
  ) {
    final $$OrdenesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.vehiculoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableFilterComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiculosTableOrderingComposer
    extends Composer<_$LavaderoDatabase, $VehiculosTable> {
  $$VehiculosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patente => $composableBuilder(
    column: $table.patente,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelo => $composableBuilder(
    column: $table.modelo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cliente => $composableBuilder(
    column: $table.cliente,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notas => $composableBuilder(
    column: $table.notas,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VehiculosTableAnnotationComposer
    extends Composer<_$LavaderoDatabase, $VehiculosTable> {
  $$VehiculosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patente =>
      $composableBuilder(column: $table.patente, builder: (column) => column);

  GeneratedColumn<String> get modelo =>
      $composableBuilder(column: $table.modelo, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get cliente =>
      $composableBuilder(column: $table.cliente, builder: (column) => column);

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<String> get notas =>
      $composableBuilder(column: $table.notas, builder: (column) => column);

  Expression<T> ordenesRefs<T extends Object>(
    Expression<T> Function($$OrdenesTableAnnotationComposer a) f,
  ) {
    final $$OrdenesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.vehiculoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableAnnotationComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiculosTableTableManager
    extends
        RootTableManager<
          _$LavaderoDatabase,
          $VehiculosTable,
          Vehiculo,
          $$VehiculosTableFilterComposer,
          $$VehiculosTableOrderingComposer,
          $$VehiculosTableAnnotationComposer,
          $$VehiculosTableCreateCompanionBuilder,
          $$VehiculosTableUpdateCompanionBuilder,
          (Vehiculo, $$VehiculosTableReferences),
          Vehiculo,
          PrefetchHooks Function({bool ordenesRefs})
        > {
  $$VehiculosTableTableManager(_$LavaderoDatabase db, $VehiculosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehiculosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehiculosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehiculosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> patente = const Value.absent(),
                Value<String> modelo = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<String> cliente = const Value.absent(),
                Value<String> telefono = const Value.absent(),
                Value<String> notas = const Value.absent(),
              }) => VehiculosCompanion(
                id: id,
                patente: patente,
                modelo: modelo,
                tipo: tipo,
                cliente: cliente,
                telefono: telefono,
                notas: notas,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String patente,
                required String modelo,
                required String tipo,
                Value<String> cliente = const Value.absent(),
                Value<String> telefono = const Value.absent(),
                Value<String> notas = const Value.absent(),
              }) => VehiculosCompanion.insert(
                id: id,
                patente: patente,
                modelo: modelo,
                tipo: tipo,
                cliente: cliente,
                telefono: telefono,
                notas: notas,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VehiculosTable, Vehiculo>(table),
                  $$VehiculosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ordenesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ordenesRefs) db.ordenes],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ordenesRefs)
                    await $_getPrefetchedDataByColumns<
                      Vehiculo,
                      $VehiculosTable,
                      OrdenLavado,
                      $OrdenesTable
                    >(
                      currentTable: table,
                      referencedTable: $$VehiculosTableReferences
                          ._ordenesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$VehiculosTableReferences(db, table, p0).ordenesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'vehiculo_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$VehiculosTableProcessedTableManager =
    ProcessedTableManager<
      _$LavaderoDatabase,
      $VehiculosTable,
      Vehiculo,
      $$VehiculosTableFilterComposer,
      $$VehiculosTableOrderingComposer,
      $$VehiculosTableAnnotationComposer,
      $$VehiculosTableCreateCompanionBuilder,
      $$VehiculosTableUpdateCompanionBuilder,
      (Vehiculo, $$VehiculosTableReferences),
      Vehiculo,
      PrefetchHooks Function({bool ordenesRefs})
    >;
typedef $$OrdenesTableCreateCompanionBuilder =
    OrdenesCompanion Function({
      Value<int> id,
      required int vehiculoId,
      required String patente,
      required String modelo,
      required String tipo,
      required String cliente,
      required String telefono,
      Value<String> responsable,
      Value<String> notas,
      Value<String> estado,
      Value<DateTime> creada,
      Value<DateTime?> programada,
      Value<DateTime?> iniciada,
      Value<DateTime?> terminada,
      Value<DateTime?> entregada,
      required String operacion,
    });
typedef $$OrdenesTableUpdateCompanionBuilder =
    OrdenesCompanion Function({
      Value<int> id,
      Value<int> vehiculoId,
      Value<String> patente,
      Value<String> modelo,
      Value<String> tipo,
      Value<String> cliente,
      Value<String> telefono,
      Value<String> responsable,
      Value<String> notas,
      Value<String> estado,
      Value<DateTime> creada,
      Value<DateTime?> programada,
      Value<DateTime?> iniciada,
      Value<DateTime?> terminada,
      Value<DateTime?> entregada,
      Value<String> operacion,
    });

final class $$OrdenesTableReferences
    extends BaseReferences<_$LavaderoDatabase, $OrdenesTable, OrdenLavado> {
  $$OrdenesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiculosTable _vehiculoIdTable(_$LavaderoDatabase db) =>
      db.vehiculos.createAlias('ordenes__vehiculo_id__vehiculos__id');

  $$VehiculosTableProcessedTableManager get vehiculoId {
    final $_column = $_itemColumn<int>('vehiculo_id')!;

    final manager = $$VehiculosTableTableManager(
      $_db,
      $_db.vehiculos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehiculoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LineasOrdenTable, List<LineaLavado>>
  _lineasOrdenRefsTable(_$LavaderoDatabase db) => MultiTypedResultKey.fromTable(
    db.lineasOrden,
    aliasName: 'ordenes__id__lineas_orden__orden_id',
  );

  $$LineasOrdenTableProcessedTableManager get lineasOrdenRefs {
    final manager = $$LineasOrdenTableTableManager(
      $_db,
      $_db.lineasOrden,
    ).filter((f) => f.ordenId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_lineasOrdenRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MovimientosStockTable, List<MovimientoInsumo>>
  _movimientosStockRefsTable(_$LavaderoDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.movimientosStock,
        aliasName: 'ordenes__id__movimientos_stock__orden_id',
      );

  $$MovimientosStockTableProcessedTableManager get movimientosStockRefs {
    final manager = $$MovimientosStockTableTableManager(
      $_db,
      $_db.movimientosStock,
    ).filter((f) => f.ordenId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _movimientosStockRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MovimientosCajaTable, List<MovimientoCaja>>
  _movimientosCajaRefsTable(_$LavaderoDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.movimientosCaja,
        aliasName: 'ordenes__id__movimientos_caja__orden_id',
      );

  $$MovimientosCajaTableProcessedTableManager get movimientosCajaRefs {
    final manager = $$MovimientosCajaTableTableManager(
      $_db,
      $_db.movimientosCaja,
    ).filter((f) => f.ordenId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _movimientosCajaRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$OrdenesTableFilterComposer
    extends Composer<_$LavaderoDatabase, $OrdenesTable> {
  $$OrdenesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patente => $composableBuilder(
    column: $table.patente,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelo => $composableBuilder(
    column: $table.modelo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cliente => $composableBuilder(
    column: $table.cliente,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get responsable => $composableBuilder(
    column: $table.responsable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notas => $composableBuilder(
    column: $table.notas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creada => $composableBuilder(
    column: $table.creada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get programada => $composableBuilder(
    column: $table.programada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get iniciada => $composableBuilder(
    column: $table.iniciada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get terminada => $composableBuilder(
    column: $table.terminada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get entregada => $composableBuilder(
    column: $table.entregada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operacion => $composableBuilder(
    column: $table.operacion,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiculosTableFilterComposer get vehiculoId {
    final $$VehiculosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehiculoId,
      referencedTable: $db.vehiculos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculosTableFilterComposer(
            $db: $db,
            $table: $db.vehiculos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> lineasOrdenRefs(
    Expression<bool> Function($$LineasOrdenTableFilterComposer f) f,
  ) {
    final $$LineasOrdenTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lineasOrden,
      getReferencedColumn: (t) => t.ordenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LineasOrdenTableFilterComposer(
            $db: $db,
            $table: $db.lineasOrden,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> movimientosStockRefs(
    Expression<bool> Function($$MovimientosStockTableFilterComposer f) f,
  ) {
    final $$MovimientosStockTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movimientosStock,
      getReferencedColumn: (t) => t.ordenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovimientosStockTableFilterComposer(
            $db: $db,
            $table: $db.movimientosStock,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> movimientosCajaRefs(
    Expression<bool> Function($$MovimientosCajaTableFilterComposer f) f,
  ) {
    final $$MovimientosCajaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movimientosCaja,
      getReferencedColumn: (t) => t.ordenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovimientosCajaTableFilterComposer(
            $db: $db,
            $table: $db.movimientosCaja,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrdenesTableOrderingComposer
    extends Composer<_$LavaderoDatabase, $OrdenesTable> {
  $$OrdenesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patente => $composableBuilder(
    column: $table.patente,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelo => $composableBuilder(
    column: $table.modelo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cliente => $composableBuilder(
    column: $table.cliente,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get responsable => $composableBuilder(
    column: $table.responsable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notas => $composableBuilder(
    column: $table.notas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creada => $composableBuilder(
    column: $table.creada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get programada => $composableBuilder(
    column: $table.programada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get iniciada => $composableBuilder(
    column: $table.iniciada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get terminada => $composableBuilder(
    column: $table.terminada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get entregada => $composableBuilder(
    column: $table.entregada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operacion => $composableBuilder(
    column: $table.operacion,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiculosTableOrderingComposer get vehiculoId {
    final $$VehiculosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehiculoId,
      referencedTable: $db.vehiculos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculosTableOrderingComposer(
            $db: $db,
            $table: $db.vehiculos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrdenesTableAnnotationComposer
    extends Composer<_$LavaderoDatabase, $OrdenesTable> {
  $$OrdenesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patente =>
      $composableBuilder(column: $table.patente, builder: (column) => column);

  GeneratedColumn<String> get modelo =>
      $composableBuilder(column: $table.modelo, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get cliente =>
      $composableBuilder(column: $table.cliente, builder: (column) => column);

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<String> get responsable => $composableBuilder(
    column: $table.responsable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notas =>
      $composableBuilder(column: $table.notas, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<DateTime> get creada =>
      $composableBuilder(column: $table.creada, builder: (column) => column);

  GeneratedColumn<DateTime> get programada => $composableBuilder(
    column: $table.programada,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get iniciada =>
      $composableBuilder(column: $table.iniciada, builder: (column) => column);

  GeneratedColumn<DateTime> get terminada =>
      $composableBuilder(column: $table.terminada, builder: (column) => column);

  GeneratedColumn<DateTime> get entregada =>
      $composableBuilder(column: $table.entregada, builder: (column) => column);

  GeneratedColumn<String> get operacion =>
      $composableBuilder(column: $table.operacion, builder: (column) => column);

  $$VehiculosTableAnnotationComposer get vehiculoId {
    final $$VehiculosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehiculoId,
      referencedTable: $db.vehiculos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculosTableAnnotationComposer(
            $db: $db,
            $table: $db.vehiculos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> lineasOrdenRefs<T extends Object>(
    Expression<T> Function($$LineasOrdenTableAnnotationComposer a) f,
  ) {
    final $$LineasOrdenTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lineasOrden,
      getReferencedColumn: (t) => t.ordenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LineasOrdenTableAnnotationComposer(
            $db: $db,
            $table: $db.lineasOrden,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> movimientosStockRefs<T extends Object>(
    Expression<T> Function($$MovimientosStockTableAnnotationComposer a) f,
  ) {
    final $$MovimientosStockTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movimientosStock,
      getReferencedColumn: (t) => t.ordenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovimientosStockTableAnnotationComposer(
            $db: $db,
            $table: $db.movimientosStock,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> movimientosCajaRefs<T extends Object>(
    Expression<T> Function($$MovimientosCajaTableAnnotationComposer a) f,
  ) {
    final $$MovimientosCajaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movimientosCaja,
      getReferencedColumn: (t) => t.ordenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovimientosCajaTableAnnotationComposer(
            $db: $db,
            $table: $db.movimientosCaja,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrdenesTableTableManager
    extends
        RootTableManager<
          _$LavaderoDatabase,
          $OrdenesTable,
          OrdenLavado,
          $$OrdenesTableFilterComposer,
          $$OrdenesTableOrderingComposer,
          $$OrdenesTableAnnotationComposer,
          $$OrdenesTableCreateCompanionBuilder,
          $$OrdenesTableUpdateCompanionBuilder,
          (OrdenLavado, $$OrdenesTableReferences),
          OrdenLavado,
          PrefetchHooks Function({
            bool vehiculoId,
            bool lineasOrdenRefs,
            bool movimientosStockRefs,
            bool movimientosCajaRefs,
          })
        > {
  $$OrdenesTableTableManager(_$LavaderoDatabase db, $OrdenesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdenesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdenesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdenesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> vehiculoId = const Value.absent(),
                Value<String> patente = const Value.absent(),
                Value<String> modelo = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<String> cliente = const Value.absent(),
                Value<String> telefono = const Value.absent(),
                Value<String> responsable = const Value.absent(),
                Value<String> notas = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<DateTime> creada = const Value.absent(),
                Value<DateTime?> programada = const Value.absent(),
                Value<DateTime?> iniciada = const Value.absent(),
                Value<DateTime?> terminada = const Value.absent(),
                Value<DateTime?> entregada = const Value.absent(),
                Value<String> operacion = const Value.absent(),
              }) => OrdenesCompanion(
                id: id,
                vehiculoId: vehiculoId,
                patente: patente,
                modelo: modelo,
                tipo: tipo,
                cliente: cliente,
                telefono: telefono,
                responsable: responsable,
                notas: notas,
                estado: estado,
                creada: creada,
                programada: programada,
                iniciada: iniciada,
                terminada: terminada,
                entregada: entregada,
                operacion: operacion,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int vehiculoId,
                required String patente,
                required String modelo,
                required String tipo,
                required String cliente,
                required String telefono,
                Value<String> responsable = const Value.absent(),
                Value<String> notas = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<DateTime> creada = const Value.absent(),
                Value<DateTime?> programada = const Value.absent(),
                Value<DateTime?> iniciada = const Value.absent(),
                Value<DateTime?> terminada = const Value.absent(),
                Value<DateTime?> entregada = const Value.absent(),
                required String operacion,
              }) => OrdenesCompanion.insert(
                id: id,
                vehiculoId: vehiculoId,
                patente: patente,
                modelo: modelo,
                tipo: tipo,
                cliente: cliente,
                telefono: telefono,
                responsable: responsable,
                notas: notas,
                estado: estado,
                creada: creada,
                programada: programada,
                iniciada: iniciada,
                terminada: terminada,
                entregada: entregada,
                operacion: operacion,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$OrdenesTable, OrdenLavado>(table),
                  $$OrdenesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                vehiculoId = false,
                lineasOrdenRefs = false,
                movimientosStockRefs = false,
                movimientosCajaRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (lineasOrdenRefs) db.lineasOrden,
                    if (movimientosStockRefs) db.movimientosStock,
                    if (movimientosCajaRefs) db.movimientosCaja,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (vehiculoId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.vehiculoId,
                                    referencedTable: $$OrdenesTableReferences
                                        ._vehiculoIdTable(db),
                                    referencedColumn: $$OrdenesTableReferences
                                        ._vehiculoIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (lineasOrdenRefs)
                        await $_getPrefetchedDataByColumns<
                          OrdenLavado,
                          $OrdenesTable,
                          LineaLavado,
                          $LineasOrdenTable
                        >(
                          currentTable: table,
                          referencedTable: $$OrdenesTableReferences
                              ._lineasOrdenRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrdenesTableReferences(
                                db,
                                table,
                                p0,
                              ).lineasOrdenRefs,
                          currentColumn: 'id',
                          referencedColumn: 'orden_id',
                          typedResults: items,
                        ),
                      if (movimientosStockRefs)
                        await $_getPrefetchedDataByColumns<
                          OrdenLavado,
                          $OrdenesTable,
                          MovimientoInsumo,
                          $MovimientosStockTable
                        >(
                          currentTable: table,
                          referencedTable: $$OrdenesTableReferences
                              ._movimientosStockRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrdenesTableReferences(
                                db,
                                table,
                                p0,
                              ).movimientosStockRefs,
                          currentColumn: 'id',
                          referencedColumn: 'orden_id',
                          typedResults: items,
                        ),
                      if (movimientosCajaRefs)
                        await $_getPrefetchedDataByColumns<
                          OrdenLavado,
                          $OrdenesTable,
                          MovimientoCaja,
                          $MovimientosCajaTable
                        >(
                          currentTable: table,
                          referencedTable: $$OrdenesTableReferences
                              ._movimientosCajaRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrdenesTableReferences(
                                db,
                                table,
                                p0,
                              ).movimientosCajaRefs,
                          currentColumn: 'id',
                          referencedColumn: 'orden_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$OrdenesTableProcessedTableManager =
    ProcessedTableManager<
      _$LavaderoDatabase,
      $OrdenesTable,
      OrdenLavado,
      $$OrdenesTableFilterComposer,
      $$OrdenesTableOrderingComposer,
      $$OrdenesTableAnnotationComposer,
      $$OrdenesTableCreateCompanionBuilder,
      $$OrdenesTableUpdateCompanionBuilder,
      (OrdenLavado, $$OrdenesTableReferences),
      OrdenLavado,
      PrefetchHooks Function({
        bool vehiculoId,
        bool lineasOrdenRefs,
        bool movimientosStockRefs,
        bool movimientosCajaRefs,
      })
    >;
typedef $$LineasOrdenTableCreateCompanionBuilder =
    LineasOrdenCompanion Function({
      Value<int> id,
      required int ordenId,
      required int servicioId,
      required String nombre,
      required int precio,
      required int duracion,
      required int costoInsumos,
      required int costoManoDeObra,
      required String receta,
    });
typedef $$LineasOrdenTableUpdateCompanionBuilder =
    LineasOrdenCompanion Function({
      Value<int> id,
      Value<int> ordenId,
      Value<int> servicioId,
      Value<String> nombre,
      Value<int> precio,
      Value<int> duracion,
      Value<int> costoInsumos,
      Value<int> costoManoDeObra,
      Value<String> receta,
    });

final class $$LineasOrdenTableReferences
    extends BaseReferences<_$LavaderoDatabase, $LineasOrdenTable, LineaLavado> {
  $$LineasOrdenTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrdenesTable _ordenIdTable(_$LavaderoDatabase db) =>
      db.ordenes.createAlias('lineas_orden__orden_id__ordenes__id');

  $$OrdenesTableProcessedTableManager get ordenId {
    final $_column = $_itemColumn<int>('orden_id')!;

    final manager = $$OrdenesTableTableManager(
      $_db,
      $_db.ordenes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ordenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ServiciosTable _servicioIdTable(_$LavaderoDatabase db) =>
      db.servicios.createAlias('lineas_orden__servicio_id__servicios__id');

  $$ServiciosTableProcessedTableManager get servicioId {
    final $_column = $_itemColumn<int>('servicio_id')!;

    final manager = $$ServiciosTableTableManager(
      $_db,
      $_db.servicios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_servicioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LineasOrdenTableFilterComposer
    extends Composer<_$LavaderoDatabase, $LineasOrdenTable> {
  $$LineasOrdenTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get precio => $composableBuilder(
    column: $table.precio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duracion => $composableBuilder(
    column: $table.duracion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costoInsumos => $composableBuilder(
    column: $table.costoInsumos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costoManoDeObra => $composableBuilder(
    column: $table.costoManoDeObra,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receta => $composableBuilder(
    column: $table.receta,
    builder: (column) => ColumnFilters(column),
  );

  $$OrdenesTableFilterComposer get ordenId {
    final $$OrdenesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ordenId,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableFilterComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ServiciosTableFilterComposer get servicioId {
    final $$ServiciosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.servicioId,
      referencedTable: $db.servicios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiciosTableFilterComposer(
            $db: $db,
            $table: $db.servicios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LineasOrdenTableOrderingComposer
    extends Composer<_$LavaderoDatabase, $LineasOrdenTable> {
  $$LineasOrdenTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get precio => $composableBuilder(
    column: $table.precio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duracion => $composableBuilder(
    column: $table.duracion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costoInsumos => $composableBuilder(
    column: $table.costoInsumos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costoManoDeObra => $composableBuilder(
    column: $table.costoManoDeObra,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receta => $composableBuilder(
    column: $table.receta,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrdenesTableOrderingComposer get ordenId {
    final $$OrdenesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ordenId,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableOrderingComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ServiciosTableOrderingComposer get servicioId {
    final $$ServiciosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.servicioId,
      referencedTable: $db.servicios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiciosTableOrderingComposer(
            $db: $db,
            $table: $db.servicios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LineasOrdenTableAnnotationComposer
    extends Composer<_$LavaderoDatabase, $LineasOrdenTable> {
  $$LineasOrdenTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<int> get precio =>
      $composableBuilder(column: $table.precio, builder: (column) => column);

  GeneratedColumn<int> get duracion =>
      $composableBuilder(column: $table.duracion, builder: (column) => column);

  GeneratedColumn<int> get costoInsumos => $composableBuilder(
    column: $table.costoInsumos,
    builder: (column) => column,
  );

  GeneratedColumn<int> get costoManoDeObra => $composableBuilder(
    column: $table.costoManoDeObra,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receta =>
      $composableBuilder(column: $table.receta, builder: (column) => column);

  $$OrdenesTableAnnotationComposer get ordenId {
    final $$OrdenesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ordenId,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableAnnotationComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ServiciosTableAnnotationComposer get servicioId {
    final $$ServiciosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.servicioId,
      referencedTable: $db.servicios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiciosTableAnnotationComposer(
            $db: $db,
            $table: $db.servicios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LineasOrdenTableTableManager
    extends
        RootTableManager<
          _$LavaderoDatabase,
          $LineasOrdenTable,
          LineaLavado,
          $$LineasOrdenTableFilterComposer,
          $$LineasOrdenTableOrderingComposer,
          $$LineasOrdenTableAnnotationComposer,
          $$LineasOrdenTableCreateCompanionBuilder,
          $$LineasOrdenTableUpdateCompanionBuilder,
          (LineaLavado, $$LineasOrdenTableReferences),
          LineaLavado,
          PrefetchHooks Function({bool ordenId, bool servicioId})
        > {
  $$LineasOrdenTableTableManager(_$LavaderoDatabase db, $LineasOrdenTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LineasOrdenTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LineasOrdenTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LineasOrdenTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> ordenId = const Value.absent(),
                Value<int> servicioId = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<int> precio = const Value.absent(),
                Value<int> duracion = const Value.absent(),
                Value<int> costoInsumos = const Value.absent(),
                Value<int> costoManoDeObra = const Value.absent(),
                Value<String> receta = const Value.absent(),
              }) => LineasOrdenCompanion(
                id: id,
                ordenId: ordenId,
                servicioId: servicioId,
                nombre: nombre,
                precio: precio,
                duracion: duracion,
                costoInsumos: costoInsumos,
                costoManoDeObra: costoManoDeObra,
                receta: receta,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int ordenId,
                required int servicioId,
                required String nombre,
                required int precio,
                required int duracion,
                required int costoInsumos,
                required int costoManoDeObra,
                required String receta,
              }) => LineasOrdenCompanion.insert(
                id: id,
                ordenId: ordenId,
                servicioId: servicioId,
                nombre: nombre,
                precio: precio,
                duracion: duracion,
                costoInsumos: costoInsumos,
                costoManoDeObra: costoManoDeObra,
                receta: receta,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LineasOrdenTable, LineaLavado>(table),
                  $$LineasOrdenTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ordenId = false, servicioId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ordenId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ordenId,
                                referencedTable: $$LineasOrdenTableReferences
                                    ._ordenIdTable(db),
                                referencedColumn: $$LineasOrdenTableReferences
                                    ._ordenIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (servicioId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.servicioId,
                                referencedTable: $$LineasOrdenTableReferences
                                    ._servicioIdTable(db),
                                referencedColumn: $$LineasOrdenTableReferences
                                    ._servicioIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LineasOrdenTableProcessedTableManager =
    ProcessedTableManager<
      _$LavaderoDatabase,
      $LineasOrdenTable,
      LineaLavado,
      $$LineasOrdenTableFilterComposer,
      $$LineasOrdenTableOrderingComposer,
      $$LineasOrdenTableAnnotationComposer,
      $$LineasOrdenTableCreateCompanionBuilder,
      $$LineasOrdenTableUpdateCompanionBuilder,
      (LineaLavado, $$LineasOrdenTableReferences),
      LineaLavado,
      PrefetchHooks Function({bool ordenId, bool servicioId})
    >;
typedef $$MovimientosStockTableCreateCompanionBuilder =
    MovimientosStockCompanion Function({
      Value<int> id,
      required int insumoId,
      Value<int?> ordenId,
      required int anterior,
      required int posterior,
      required String motivo,
      Value<DateTime> fecha,
    });
typedef $$MovimientosStockTableUpdateCompanionBuilder =
    MovimientosStockCompanion Function({
      Value<int> id,
      Value<int> insumoId,
      Value<int?> ordenId,
      Value<int> anterior,
      Value<int> posterior,
      Value<String> motivo,
      Value<DateTime> fecha,
    });

final class $$MovimientosStockTableReferences
    extends
        BaseReferences<
          _$LavaderoDatabase,
          $MovimientosStockTable,
          MovimientoInsumo
        > {
  $$MovimientosStockTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $InsumosTable _insumoIdTable(_$LavaderoDatabase db) =>
      db.insumos.createAlias('movimientos_stock__insumo_id__insumos__id');

  $$InsumosTableProcessedTableManager get insumoId {
    final $_column = $_itemColumn<int>('insumo_id')!;

    final manager = $$InsumosTableTableManager(
      $_db,
      $_db.insumos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_insumoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $OrdenesTable _ordenIdTable(_$LavaderoDatabase db) =>
      db.ordenes.createAlias('movimientos_stock__orden_id__ordenes__id');

  $$OrdenesTableProcessedTableManager? get ordenId {
    final $_column = $_itemColumn<int>('orden_id');
    if ($_column == null) return null;
    final manager = $$OrdenesTableTableManager(
      $_db,
      $_db.ordenes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ordenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MovimientosStockTableFilterComposer
    extends Composer<_$LavaderoDatabase, $MovimientosStockTable> {
  $$MovimientosStockTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get anterior => $composableBuilder(
    column: $table.anterior,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get posterior => $composableBuilder(
    column: $table.posterior,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motivo => $composableBuilder(
    column: $table.motivo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  $$InsumosTableFilterComposer get insumoId {
    final $$InsumosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.insumoId,
      referencedTable: $db.insumos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InsumosTableFilterComposer(
            $db: $db,
            $table: $db.insumos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$OrdenesTableFilterComposer get ordenId {
    final $$OrdenesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ordenId,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableFilterComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovimientosStockTableOrderingComposer
    extends Composer<_$LavaderoDatabase, $MovimientosStockTable> {
  $$MovimientosStockTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get anterior => $composableBuilder(
    column: $table.anterior,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get posterior => $composableBuilder(
    column: $table.posterior,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motivo => $composableBuilder(
    column: $table.motivo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  $$InsumosTableOrderingComposer get insumoId {
    final $$InsumosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.insumoId,
      referencedTable: $db.insumos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InsumosTableOrderingComposer(
            $db: $db,
            $table: $db.insumos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$OrdenesTableOrderingComposer get ordenId {
    final $$OrdenesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ordenId,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableOrderingComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovimientosStockTableAnnotationComposer
    extends Composer<_$LavaderoDatabase, $MovimientosStockTable> {
  $$MovimientosStockTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get anterior =>
      $composableBuilder(column: $table.anterior, builder: (column) => column);

  GeneratedColumn<int> get posterior =>
      $composableBuilder(column: $table.posterior, builder: (column) => column);

  GeneratedColumn<String> get motivo =>
      $composableBuilder(column: $table.motivo, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  $$InsumosTableAnnotationComposer get insumoId {
    final $$InsumosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.insumoId,
      referencedTable: $db.insumos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InsumosTableAnnotationComposer(
            $db: $db,
            $table: $db.insumos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$OrdenesTableAnnotationComposer get ordenId {
    final $$OrdenesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ordenId,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableAnnotationComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovimientosStockTableTableManager
    extends
        RootTableManager<
          _$LavaderoDatabase,
          $MovimientosStockTable,
          MovimientoInsumo,
          $$MovimientosStockTableFilterComposer,
          $$MovimientosStockTableOrderingComposer,
          $$MovimientosStockTableAnnotationComposer,
          $$MovimientosStockTableCreateCompanionBuilder,
          $$MovimientosStockTableUpdateCompanionBuilder,
          (MovimientoInsumo, $$MovimientosStockTableReferences),
          MovimientoInsumo,
          PrefetchHooks Function({bool insumoId, bool ordenId})
        > {
  $$MovimientosStockTableTableManager(
    _$LavaderoDatabase db,
    $MovimientosStockTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovimientosStockTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MovimientosStockTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MovimientosStockTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> insumoId = const Value.absent(),
                Value<int?> ordenId = const Value.absent(),
                Value<int> anterior = const Value.absent(),
                Value<int> posterior = const Value.absent(),
                Value<String> motivo = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
              }) => MovimientosStockCompanion(
                id: id,
                insumoId: insumoId,
                ordenId: ordenId,
                anterior: anterior,
                posterior: posterior,
                motivo: motivo,
                fecha: fecha,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int insumoId,
                Value<int?> ordenId = const Value.absent(),
                required int anterior,
                required int posterior,
                required String motivo,
                Value<DateTime> fecha = const Value.absent(),
              }) => MovimientosStockCompanion.insert(
                id: id,
                insumoId: insumoId,
                ordenId: ordenId,
                anterior: anterior,
                posterior: posterior,
                motivo: motivo,
                fecha: fecha,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MovimientosStockTable, MovimientoInsumo>(table),
                  $$MovimientosStockTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({insumoId = false, ordenId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (insumoId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.insumoId,
                                referencedTable:
                                    $$MovimientosStockTableReferences
                                        ._insumoIdTable(db),
                                referencedColumn:
                                    $$MovimientosStockTableReferences
                                        ._insumoIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (ordenId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ordenId,
                                referencedTable:
                                    $$MovimientosStockTableReferences
                                        ._ordenIdTable(db),
                                referencedColumn:
                                    $$MovimientosStockTableReferences
                                        ._ordenIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MovimientosStockTableProcessedTableManager =
    ProcessedTableManager<
      _$LavaderoDatabase,
      $MovimientosStockTable,
      MovimientoInsumo,
      $$MovimientosStockTableFilterComposer,
      $$MovimientosStockTableOrderingComposer,
      $$MovimientosStockTableAnnotationComposer,
      $$MovimientosStockTableCreateCompanionBuilder,
      $$MovimientosStockTableUpdateCompanionBuilder,
      (MovimientoInsumo, $$MovimientosStockTableReferences),
      MovimientoInsumo,
      PrefetchHooks Function({bool insumoId, bool ordenId})
    >;
typedef $$CajasTableCreateCompanionBuilder =
    CajasCompanion Function({
      Value<int> id,
      Value<DateTime> abierta,
      Value<DateTime?> cerrada,
      required int inicialEfectivo,
      required int inicialDigital,
      Value<int?> contadoEfectivo,
      Value<int?> contadoDigital,
    });
typedef $$CajasTableUpdateCompanionBuilder =
    CajasCompanion Function({
      Value<int> id,
      Value<DateTime> abierta,
      Value<DateTime?> cerrada,
      Value<int> inicialEfectivo,
      Value<int> inicialDigital,
      Value<int?> contadoEfectivo,
      Value<int?> contadoDigital,
    });

final class $$CajasTableReferences
    extends BaseReferences<_$LavaderoDatabase, $CajasTable, SesionCaja> {
  $$CajasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MovimientosCajaTable, List<MovimientoCaja>>
  _movimientosCajaRefsTable(_$LavaderoDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.movimientosCaja,
        aliasName: 'cajas__id__movimientos_caja__caja_id',
      );

  $$MovimientosCajaTableProcessedTableManager get movimientosCajaRefs {
    final manager = $$MovimientosCajaTableTableManager(
      $_db,
      $_db.movimientosCaja,
    ).filter((f) => f.cajaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _movimientosCajaRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CajasTableFilterComposer
    extends Composer<_$LavaderoDatabase, $CajasTable> {
  $$CajasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get abierta => $composableBuilder(
    column: $table.abierta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cerrada => $composableBuilder(
    column: $table.cerrada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get inicialEfectivo => $composableBuilder(
    column: $table.inicialEfectivo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get inicialDigital => $composableBuilder(
    column: $table.inicialDigital,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get contadoEfectivo => $composableBuilder(
    column: $table.contadoEfectivo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get contadoDigital => $composableBuilder(
    column: $table.contadoDigital,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> movimientosCajaRefs(
    Expression<bool> Function($$MovimientosCajaTableFilterComposer f) f,
  ) {
    final $$MovimientosCajaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movimientosCaja,
      getReferencedColumn: (t) => t.cajaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovimientosCajaTableFilterComposer(
            $db: $db,
            $table: $db.movimientosCaja,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CajasTableOrderingComposer
    extends Composer<_$LavaderoDatabase, $CajasTable> {
  $$CajasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get abierta => $composableBuilder(
    column: $table.abierta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cerrada => $composableBuilder(
    column: $table.cerrada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get inicialEfectivo => $composableBuilder(
    column: $table.inicialEfectivo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get inicialDigital => $composableBuilder(
    column: $table.inicialDigital,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get contadoEfectivo => $composableBuilder(
    column: $table.contadoEfectivo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get contadoDigital => $composableBuilder(
    column: $table.contadoDigital,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CajasTableAnnotationComposer
    extends Composer<_$LavaderoDatabase, $CajasTable> {
  $$CajasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get abierta =>
      $composableBuilder(column: $table.abierta, builder: (column) => column);

  GeneratedColumn<DateTime> get cerrada =>
      $composableBuilder(column: $table.cerrada, builder: (column) => column);

  GeneratedColumn<int> get inicialEfectivo => $composableBuilder(
    column: $table.inicialEfectivo,
    builder: (column) => column,
  );

  GeneratedColumn<int> get inicialDigital => $composableBuilder(
    column: $table.inicialDigital,
    builder: (column) => column,
  );

  GeneratedColumn<int> get contadoEfectivo => $composableBuilder(
    column: $table.contadoEfectivo,
    builder: (column) => column,
  );

  GeneratedColumn<int> get contadoDigital => $composableBuilder(
    column: $table.contadoDigital,
    builder: (column) => column,
  );

  Expression<T> movimientosCajaRefs<T extends Object>(
    Expression<T> Function($$MovimientosCajaTableAnnotationComposer a) f,
  ) {
    final $$MovimientosCajaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movimientosCaja,
      getReferencedColumn: (t) => t.cajaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovimientosCajaTableAnnotationComposer(
            $db: $db,
            $table: $db.movimientosCaja,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CajasTableTableManager
    extends
        RootTableManager<
          _$LavaderoDatabase,
          $CajasTable,
          SesionCaja,
          $$CajasTableFilterComposer,
          $$CajasTableOrderingComposer,
          $$CajasTableAnnotationComposer,
          $$CajasTableCreateCompanionBuilder,
          $$CajasTableUpdateCompanionBuilder,
          (SesionCaja, $$CajasTableReferences),
          SesionCaja,
          PrefetchHooks Function({bool movimientosCajaRefs})
        > {
  $$CajasTableTableManager(_$LavaderoDatabase db, $CajasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CajasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CajasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CajasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> abierta = const Value.absent(),
                Value<DateTime?> cerrada = const Value.absent(),
                Value<int> inicialEfectivo = const Value.absent(),
                Value<int> inicialDigital = const Value.absent(),
                Value<int?> contadoEfectivo = const Value.absent(),
                Value<int?> contadoDigital = const Value.absent(),
              }) => CajasCompanion(
                id: id,
                abierta: abierta,
                cerrada: cerrada,
                inicialEfectivo: inicialEfectivo,
                inicialDigital: inicialDigital,
                contadoEfectivo: contadoEfectivo,
                contadoDigital: contadoDigital,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> abierta = const Value.absent(),
                Value<DateTime?> cerrada = const Value.absent(),
                required int inicialEfectivo,
                required int inicialDigital,
                Value<int?> contadoEfectivo = const Value.absent(),
                Value<int?> contadoDigital = const Value.absent(),
              }) => CajasCompanion.insert(
                id: id,
                abierta: abierta,
                cerrada: cerrada,
                inicialEfectivo: inicialEfectivo,
                inicialDigital: inicialDigital,
                contadoEfectivo: contadoEfectivo,
                contadoDigital: contadoDigital,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CajasTable, SesionCaja>(table),
                  $$CajasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({movimientosCajaRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (movimientosCajaRefs) db.movimientosCaja,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (movimientosCajaRefs)
                    await $_getPrefetchedDataByColumns<
                      SesionCaja,
                      $CajasTable,
                      MovimientoCaja,
                      $MovimientosCajaTable
                    >(
                      currentTable: table,
                      referencedTable: $$CajasTableReferences
                          ._movimientosCajaRefsTable(db),
                      managerFromTypedResult: (p0) => $$CajasTableReferences(
                        db,
                        table,
                        p0,
                      ).movimientosCajaRefs,
                      currentColumn: 'id',
                      referencedColumn: 'caja_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CajasTableProcessedTableManager =
    ProcessedTableManager<
      _$LavaderoDatabase,
      $CajasTable,
      SesionCaja,
      $$CajasTableFilterComposer,
      $$CajasTableOrderingComposer,
      $$CajasTableAnnotationComposer,
      $$CajasTableCreateCompanionBuilder,
      $$CajasTableUpdateCompanionBuilder,
      (SesionCaja, $$CajasTableReferences),
      SesionCaja,
      PrefetchHooks Function({bool movimientosCajaRefs})
    >;
typedef $$MovimientosCajaTableCreateCompanionBuilder =
    MovimientosCajaCompanion Function({
      Value<int> id,
      required int cajaId,
      Value<int?> ordenId,
      required String medio,
      required int monto,
      required String concepto,
      required String clase,
      required String operacion,
      Value<DateTime> fecha,
    });
typedef $$MovimientosCajaTableUpdateCompanionBuilder =
    MovimientosCajaCompanion Function({
      Value<int> id,
      Value<int> cajaId,
      Value<int?> ordenId,
      Value<String> medio,
      Value<int> monto,
      Value<String> concepto,
      Value<String> clase,
      Value<String> operacion,
      Value<DateTime> fecha,
    });

final class $$MovimientosCajaTableReferences
    extends
        BaseReferences<
          _$LavaderoDatabase,
          $MovimientosCajaTable,
          MovimientoCaja
        > {
  $$MovimientosCajaTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CajasTable _cajaIdTable(_$LavaderoDatabase db) =>
      db.cajas.createAlias('movimientos_caja__caja_id__cajas__id');

  $$CajasTableProcessedTableManager get cajaId {
    final $_column = $_itemColumn<int>('caja_id')!;

    final manager = $$CajasTableTableManager(
      $_db,
      $_db.cajas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cajaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $OrdenesTable _ordenIdTable(_$LavaderoDatabase db) =>
      db.ordenes.createAlias('movimientos_caja__orden_id__ordenes__id');

  $$OrdenesTableProcessedTableManager? get ordenId {
    final $_column = $_itemColumn<int>('orden_id');
    if ($_column == null) return null;
    final manager = $$OrdenesTableTableManager(
      $_db,
      $_db.ordenes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ordenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MovimientosCajaTableFilterComposer
    extends Composer<_$LavaderoDatabase, $MovimientosCajaTable> {
  $$MovimientosCajaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get medio => $composableBuilder(
    column: $table.medio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get concepto => $composableBuilder(
    column: $table.concepto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clase => $composableBuilder(
    column: $table.clase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operacion => $composableBuilder(
    column: $table.operacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  $$CajasTableFilterComposer get cajaId {
    final $$CajasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cajaId,
      referencedTable: $db.cajas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CajasTableFilterComposer(
            $db: $db,
            $table: $db.cajas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$OrdenesTableFilterComposer get ordenId {
    final $$OrdenesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ordenId,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableFilterComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovimientosCajaTableOrderingComposer
    extends Composer<_$LavaderoDatabase, $MovimientosCajaTable> {
  $$MovimientosCajaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get medio => $composableBuilder(
    column: $table.medio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get concepto => $composableBuilder(
    column: $table.concepto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clase => $composableBuilder(
    column: $table.clase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operacion => $composableBuilder(
    column: $table.operacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  $$CajasTableOrderingComposer get cajaId {
    final $$CajasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cajaId,
      referencedTable: $db.cajas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CajasTableOrderingComposer(
            $db: $db,
            $table: $db.cajas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$OrdenesTableOrderingComposer get ordenId {
    final $$OrdenesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ordenId,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableOrderingComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovimientosCajaTableAnnotationComposer
    extends Composer<_$LavaderoDatabase, $MovimientosCajaTable> {
  $$MovimientosCajaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get medio =>
      $composableBuilder(column: $table.medio, builder: (column) => column);

  GeneratedColumn<int> get monto =>
      $composableBuilder(column: $table.monto, builder: (column) => column);

  GeneratedColumn<String> get concepto =>
      $composableBuilder(column: $table.concepto, builder: (column) => column);

  GeneratedColumn<String> get clase =>
      $composableBuilder(column: $table.clase, builder: (column) => column);

  GeneratedColumn<String> get operacion =>
      $composableBuilder(column: $table.operacion, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  $$CajasTableAnnotationComposer get cajaId {
    final $$CajasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cajaId,
      referencedTable: $db.cajas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CajasTableAnnotationComposer(
            $db: $db,
            $table: $db.cajas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$OrdenesTableAnnotationComposer get ordenId {
    final $$OrdenesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ordenId,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableAnnotationComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovimientosCajaTableTableManager
    extends
        RootTableManager<
          _$LavaderoDatabase,
          $MovimientosCajaTable,
          MovimientoCaja,
          $$MovimientosCajaTableFilterComposer,
          $$MovimientosCajaTableOrderingComposer,
          $$MovimientosCajaTableAnnotationComposer,
          $$MovimientosCajaTableCreateCompanionBuilder,
          $$MovimientosCajaTableUpdateCompanionBuilder,
          (MovimientoCaja, $$MovimientosCajaTableReferences),
          MovimientoCaja,
          PrefetchHooks Function({bool cajaId, bool ordenId})
        > {
  $$MovimientosCajaTableTableManager(
    _$LavaderoDatabase db,
    $MovimientosCajaTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovimientosCajaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MovimientosCajaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MovimientosCajaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> cajaId = const Value.absent(),
                Value<int?> ordenId = const Value.absent(),
                Value<String> medio = const Value.absent(),
                Value<int> monto = const Value.absent(),
                Value<String> concepto = const Value.absent(),
                Value<String> clase = const Value.absent(),
                Value<String> operacion = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
              }) => MovimientosCajaCompanion(
                id: id,
                cajaId: cajaId,
                ordenId: ordenId,
                medio: medio,
                monto: monto,
                concepto: concepto,
                clase: clase,
                operacion: operacion,
                fecha: fecha,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int cajaId,
                Value<int?> ordenId = const Value.absent(),
                required String medio,
                required int monto,
                required String concepto,
                required String clase,
                required String operacion,
                Value<DateTime> fecha = const Value.absent(),
              }) => MovimientosCajaCompanion.insert(
                id: id,
                cajaId: cajaId,
                ordenId: ordenId,
                medio: medio,
                monto: monto,
                concepto: concepto,
                clase: clase,
                operacion: operacion,
                fecha: fecha,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MovimientosCajaTable, MovimientoCaja>(table),
                  $$MovimientosCajaTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cajaId = false, ordenId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (cajaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.cajaId,
                                referencedTable:
                                    $$MovimientosCajaTableReferences
                                        ._cajaIdTable(db),
                                referencedColumn:
                                    $$MovimientosCajaTableReferences
                                        ._cajaIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (ordenId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ordenId,
                                referencedTable:
                                    $$MovimientosCajaTableReferences
                                        ._ordenIdTable(db),
                                referencedColumn:
                                    $$MovimientosCajaTableReferences
                                        ._ordenIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MovimientosCajaTableProcessedTableManager =
    ProcessedTableManager<
      _$LavaderoDatabase,
      $MovimientosCajaTable,
      MovimientoCaja,
      $$MovimientosCajaTableFilterComposer,
      $$MovimientosCajaTableOrderingComposer,
      $$MovimientosCajaTableAnnotationComposer,
      $$MovimientosCajaTableCreateCompanionBuilder,
      $$MovimientosCajaTableUpdateCompanionBuilder,
      (MovimientoCaja, $$MovimientosCajaTableReferences),
      MovimientoCaja,
      PrefetchHooks Function({bool cajaId, bool ordenId})
    >;

class $LavaderoDatabaseManager {
  final _$LavaderoDatabase _db;
  $LavaderoDatabaseManager(this._db);
  $$AjustesTableTableManager get ajustes =>
      $$AjustesTableTableManager(_db, _db.ajustes);
  $$InsumosTableTableManager get insumos =>
      $$InsumosTableTableManager(_db, _db.insumos);
  $$ServiciosTableTableManager get servicios =>
      $$ServiciosTableTableManager(_db, _db.servicios);
  $$TarifasTableTableManager get tarifas =>
      $$TarifasTableTableManager(_db, _db.tarifas);
  $$RecetasTableTableManager get recetas =>
      $$RecetasTableTableManager(_db, _db.recetas);
  $$VehiculosTableTableManager get vehiculos =>
      $$VehiculosTableTableManager(_db, _db.vehiculos);
  $$OrdenesTableTableManager get ordenes =>
      $$OrdenesTableTableManager(_db, _db.ordenes);
  $$LineasOrdenTableTableManager get lineasOrden =>
      $$LineasOrdenTableTableManager(_db, _db.lineasOrden);
  $$MovimientosStockTableTableManager get movimientosStock =>
      $$MovimientosStockTableTableManager(_db, _db.movimientosStock);
  $$CajasTableTableManager get cajas =>
      $$CajasTableTableManager(_db, _db.cajas);
  $$MovimientosCajaTableTableManager get movimientosCaja =>
      $$MovimientosCajaTableTableManager(_db, _db.movimientosCaja);
}
