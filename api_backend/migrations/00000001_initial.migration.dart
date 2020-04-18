import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration1 extends Migration { 
  @override
  Future upgrade() async {
   	database.createTable(SchemaTable("categoria", [SchemaColumn("id", ManagedPropertyType.integer, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("nome", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("tipoCategoria", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("usuario", [SchemaColumn("id", ManagedPropertyType.integer, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("login", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: true),SchemaColumn("senha", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("movimentacao", [SchemaColumn("id", ManagedPropertyType.integer, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("dataMovimentacao", ManagedPropertyType.datetime, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("descricao", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("valor", ManagedPropertyType.doublePrecision, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
		database.addColumn("movimentacao", SchemaColumn.relationship("usuario", ManagedPropertyType.integer, relatedTableName: "usuario", relatedColumnName: "id", rule: DeleteRule.nullify, isNullable: true, isUnique: false));
		database.addColumn("movimentacao", SchemaColumn.relationship("categoria", ManagedPropertyType.integer, relatedTableName: "categoria", relatedColumnName: "id", rule: DeleteRule.nullify, isNullable: true, isUnique: false));
  }
  
  @override
  Future downgrade() async => await store.execute("DROP TABLE categoria");
  
  @override
  Future seed() async {
    final sqls = [
      {
        'id':1, 'nome': 'Salário', 'tipocategoria':'receita'
      },
      {
        'id':2, 'nome': 'Investimento', 'tipocategoria':'receita'
      },
      {
        'id':3, 'nome': 'Aplicação', 'tipocategoria':'despesa'
      },
      {
        'id':4, 'nome': 'Contas Residenciais', 'tipocategoria':'despesa'
      },
      {
        'id':5, 'nome': 'Educação', 'tipocategoria':'despesa'
      },
      {
        'id':6, 'nome': 'Mercado', 'tipocategoria':'despesa'
      },
      {
        'id':7, 'nome': 'Moradia', 'tipocategoria':'despesa'
      },
      {
        'id':8, 'nome': 'Saúde', 'tipocategoria':'despesa'
      },
      {
        'id':9, 'nome': 'Transporte', 'tipocategoria':'despesa'
      },
      {
        'id':10, 'nome': 'Compras', 'tipocategoria':'despesa'
      },
      {
        'id':11, 'nome': 'Bar/Restaurantes', 'tipocategoria':'despesa'
      },
      {
        'id':12, 'nome': 'Cuidados Pessoais', 'tipocategoria':'despesa'
      } 
    ];

    for(final sql in sqls){
      await database.store.execute("INSERT INTO  categoria (id, nome, tipocategoria) VALUES (@id, @nome, @tipocategoria)",substitutionValues:{
        'id':sql['id'], 'nome': sql['nome'], 'tipocategoria':sql['tipocategoria']
      });
    }
  }
}
    